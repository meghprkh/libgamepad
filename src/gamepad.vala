private class LibGamepad.Dpad : Object {
	public InputType types[4];
	public int values[4];
	public int axisval[2];
}

/**
 * This class represents a gamepad
 *
 * The client interfaces with this class primarily
 */
public class LibGamepad.Gamepad : Object {

	/**
	 * Emitted when a button is pressed/released
	 * @param  button        The button pressed
	 * @param  value         True if pressed, False if released
	 */
	public signal void button_event (StandardGamepadButton button, bool value);

	/**
	 * Emitted when an axis's value changes
	 * @param  axis          The axis number from 0 to axes_number
	 * @param  value         The value of the axis ranging from -1 to 1
	 */
	public signal void axis_event (StandardGamepadAxis axis, double value);

	/**
	 * Emitted when the gamepad is unplugged
	 */
	public signal void unplugged ();


	/**
	 * The raw name reported by the driver
	 */
	public string? raw_name { get; private set; }

	/**
	 * The guid
	 */
	public string? guid { get; private set; }

	/**
	 * The name present in our database
	 */
	public string? name { get; private set; }

	/**
	 * The raw gamepad behind this gamepad
	 */
	public RawGamepad raw_gamepad { get; private set; }

	/**
	 * Whether this gamepad is mapped
	 */
	public bool mapped { get; private set; }

	private InputType[] buttons;
	private int[] buttons_value;
	private InputType[] axes;
	private int[] axes_value;
	private Dpad[] dpads;

	public Gamepad (RawGamepad raw_gamepad) throws FileError {
		this.raw_gamepad = raw_gamepad;
		mapped = false;
		raw_name = raw_gamepad.name;
		guid = raw_gamepad.guid;
		name = Mappings.get_name (guid) ?? raw_name;
		buttons.resize (raw_gamepad.buttons_number);
		buttons_value.resize (raw_gamepad.buttons_number);
		axes.resize (raw_gamepad.axes_number);
		axes_value.resize (raw_gamepad.axes_number);
		dpads.resize (raw_gamepad.dpads_number);
		for (var i = 0; i < raw_gamepad.dpads_number; i++) {
			dpads[i] = new Dpad();
			dpads[i].axisval[0] = dpads[i].axisval[1] = 0;
		}
		add_mapping (Mappings.get_mapping(guid));
		raw_gamepad.button_event.connect (on_raw_button_event);
		raw_gamepad.axis_event.connect (on_raw_axis_event);
		raw_gamepad.dpad_event.connect (on_raw_hat_event);
		raw_gamepad.unplugged.connect (() => unplugged ());
	}

	private void on_raw_button_event (int button, bool value) {
		if (!mapped)
			return;

		switch(buttons[button]) {
			case InputType.AXIS:
				axis_event((StandardGamepadAxis) buttons_value[button], (double) value);
				break;
			case InputType.BUTTON:
				button_event((StandardGamepadButton) buttons_value[button], value);
				break;
		}
	}

	private void on_raw_axis_event (int axis, double value) {
		if (!mapped)
			return;

		switch(axes[axis]) {
			case InputType.AXIS:
				axis_event((StandardGamepadAxis) axes_value[axis], value);
				break;
			case InputType.BUTTON:
				button_event((StandardGamepadButton) axes_value[axis], (bool) value);
				break;
		}
	}

	private void on_raw_hat_event (int dpadi, int axis, int value) {
		if (!mapped)
			return;

		int dpadp;
		var dpad = dpads[dpadi];
		if (value == 0)
			dpadp = (dpad.axisval[axis] + axis + 4) % 4;
		else
			dpadp = (value + axis + 4) % 4;
		dpad.axisval[axis] = value;
		value = value.abs();
		switch(dpad.types[dpadp]) {
			case InputType.AXIS:
				axis_event((StandardGamepadAxis) dpad.values[dpadp], value);
				break;
			case InputType.BUTTON:
				button_event((StandardGamepadButton) dpad.values[dpadp], (bool) value);
				break;
		}
	}

	private void add_mapping (string? mappingstring) {
		if (mappingstring == null || mappingstring == "")
			return;

		mapped = true;
		var mappings = mappingstring.split(",");
		foreach (var mapping in mappings) {
			if (mapping.split(":").length == 2) {
				var str = mapping.split(":")[0];
				var real = mapping.split(":")[1];
				var type = MappingHelpers.map_type(str);
				if (type == InputType.INVALID)
					continue;
				var value = MappingHelpers.map_value(str);
				switch (real[0]) {
				case 'h':
					var hatarr = real[1:real.length].split(".");
					var dpadi = int.parse(hatarr[0]);
					var hatp2pow = int.parse(hatarr[1]);
					var dpadp = 0;
					while (hatp2pow > 1) {
						hatp2pow >>= 1;
						dpadp++;
					}
					dpads[dpadi].types[dpadp] = type;
					dpads[dpadi].values[dpadp] = value;
					break;
				case 'b':
					int button = int.parse(real[1:real.length]);
					buttons[button] = type;
					buttons_value[button] = value;
					break;
				case 'a':
					int axis = int.parse(real[1:real.length]);
					axes[axis] = type;
					axes_value[axis] = value;
					break;
				}
			}
		}
	}
}
