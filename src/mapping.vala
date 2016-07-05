private class LibGamepad.Dpad : Object {
	public InputType types[4];
	public int values[4];
	public int axisval[2];

	public Dpad () {
		axisval[0] = axisval[1] = 0;
		types[0] = types[1] = types[2] = types[3] = InputType.INVALID;
	}
}

public class LibGamepad.Mapping : Object {
	private InputType[] buttons_type;
	private int[] buttons_value;
	private InputType[] axes_type;
	private int[] axes_value;
	private Dpad[] dpads;
	public bool mapped { get; private set; default = false; }
	public string mappingstring { private get; construct; }

	public Mapping (string mappingstring) {
		Object (mappingstring: mappingstring);
	}

	construct {
		if (mappingstring == null || mappingstring == "")
			return;

		mapped = true;
		var mappings = mappingstring.split (",");
		foreach (var mapping in mappings) {
			if (mapping.split (":").length == 2) {
				var str = mapping.split (":")[0];
				var real = mapping.split (":")[1];
				var type = MappingHelpers.map_type (str);
				if (type == InputType.INVALID)
					continue;
				var value = MappingHelpers.map_value (str);
				switch (real[0]) {
				case 'h':
					var dpad_parse_array = real[1:real.length].split (".");
					var dpad_index = int.parse (dpad_parse_array[0]);
					var dpad_position_2pow = int.parse (dpad_parse_array[1]);
					int dpad_position = 0;
					while (dpad_position_2pow > 1) {
						dpad_position_2pow >>= 1;
						dpad_position++;
					}
					while (dpads.length <= dpad_index) dpads += new Dpad ();
					dpads[dpad_index].types[dpad_position] = type;
					dpads[dpad_index].values[dpad_position] = value;
					break;
				case 'b':
					var button = int.parse (real[1:real.length]);
					while (buttons_type.length <= button) buttons_type += InputType.INVALID;
					if (buttons_value.length <= button) buttons_value.resize (button + 1);
					buttons_type[button] = type;
					buttons_value[button] = value;
					break;
				case 'a':
					var axis = int.parse (real[1:real.length]);
					while (axes_type.length <= axis) axes_type += InputType.INVALID;
					if (axes_value.length <= axis) axes_value.resize (axis + 1);
					axes_type[axis] = type;
					axes_value[axis] = value;
					break;
				}
			}
		}
	}

	public void get_dpad_mapping (int dpad_index,
	                              int dpad_axis,
	                              int dpad_value,
	                              out InputType type,
	                              out StandardGamepadAxis output_axis,
	                              out StandardGamepadButton output_button) {
		 if (!mapped)
 			return;

		int dpad_position;
		var dpad = dpads[dpad_index];
		if (dpad_value == 0)
			dpad_position = (dpad.axisval[dpad_axis] + dpad_axis + 4) % 4;
		else
			dpad_position = (dpad_value + dpad_axis + 4) % 4;
		dpad.axisval[dpad_axis] = dpad_value;
		type = dpad.types[dpad_position];
		switch (type) {
		case InputType.AXIS:
			output_axis = (StandardGamepadAxis) dpad.values[dpad_position];
			break;
		case InputType.BUTTON:
			output_button = (StandardGamepadButton) dpad.values[dpad_position];
			break;
		}
	}

	public void get_axis_mapping (int axis_number,
	                              out InputType type,
	                              out StandardGamepadAxis output_axis,
	                              out StandardGamepadButton output_button) {
		if (!mapped)
			return;

		type = axes_type[axis_number];
		switch (type) {
		case InputType.AXIS:
			output_axis = (StandardGamepadAxis) axes_value[axis_number];
			break;
		case InputType.BUTTON:
			output_button = (StandardGamepadButton) axes_value[axis_number];
			break;
		}
	}

	public void get_button_mapping (int button_number,
	                                out InputType type,
	                                out StandardGamepadAxis output_axis,
	                                out StandardGamepadButton output_button) {
		if (!mapped)
			return;

		type = buttons_type[button_number];
		switch (type) {
		case InputType.AXIS:
			output_axis = (StandardGamepadAxis) buttons_value[button_number];
			break;
		case InputType.BUTTON:
			output_button = (StandardGamepadButton) buttons_value[button_number];
			break;
		}
	}
}
