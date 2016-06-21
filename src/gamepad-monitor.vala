/**
 * This class provides a way to the client to monitor gamepads
 *
 * The client interfaces with this class primarily
 */
public class LibGamepad.GamepadMonitor : Object {
	/**
	 * The number of plugged in gamepads
	 */
	public static uint ngamepads { get; private set; default = 0; }

	/**
	 * Emitted when a gamepad is plugged in
	 * @param  g    The gamepad
	 */
	public signal void on_plugin (Gamepad g);

	/**
	 * Emitted when a gamepad is unplugged
	 * @param  identifier    The identifier of the unplugged gamepad
	 * @param  guid          The guid of the unplugged gamepad
	 * @param  name          The name of the unplugged gamepad
	 */
	public signal void on_unplug (string identifier, string guid, string? name);

	public delegate void ForeachGamepadCallback(Gamepad g);

	/**
	 * This function allows to iterate over all gamepads
	 * @param    cb          The callback
	 */
	public void foreach_gamepad (ForeachGamepadCallback cb) {
		identifier_to_raw_gamepad.foreach ((identifier, raw_gamepad) => {
			cb (new Gamepad (raw_gamepad));
		});
	}

	public GamepadMonitor() {
		init_static_if_not();

		gm = new LinuxRawGamepadMonitor ();

		gm.on_plugin.connect (on_raw_plugin);
		gm.on_unplug.connect (on_raw_unplug);

		string guid;
		string identifier;
		gm.foreach_gamepad ((raw_gamepad) => {
			add_gamepad (raw_gamepad);
		});

	}


	/**
	 * This static function returns a raw gamepad given a guid. It can be used
	 * for creating interfaces for remappable-controls.
	 * @param  identifier         The identifier of the raw gamepad that you want
	 */
	public static RawGamepad? get_raw_gamepad (string identifier) {
		init_static_if_not();

		if (identifier == null) return null;
		else return identifier_to_raw_gamepad.get (identifier);
	}

	private static HashTable<string, RawGamepad> identifier_to_raw_gamepad;
	private static HashTable<string, string> guid_to_raw_name;
	private RawGamepadMonitor gm;

	private static void init_static_if_not () {
		/*if (ngamepads == null) ngamepads = 0;*/
		if (identifier_to_raw_gamepad == null)
			identifier_to_raw_gamepad = new HashTable<string, RawGamepad> (str_hash, str_equal);
		if (guid_to_raw_name == null)
			guid_to_raw_name = new HashTable<string, string> (str_hash, str_equal);
	}

	private void add_gamepad (RawGamepad raw_gamepad) {
		ngamepads++;
		identifier_to_raw_gamepad.replace (raw_gamepad.identifier, raw_gamepad);
		guid_to_raw_name.replace (raw_gamepad.guid.to_string (), raw_gamepad.name);
	}

	private void on_raw_plugin (RawGamepad raw_gamepad) {
		add_gamepad (raw_gamepad);
		on_plugin (new Gamepad (raw_gamepad));
	}

	private void on_raw_unplug (string identifier) {
		var raw_gamepad = identifier_to_raw_gamepad.get (identifier);
		if (raw_gamepad == null) return;
		ngamepads--;
		guid_to_raw_name.remove (raw_gamepad.guid.to_string ());
		on_unplug (raw_gamepad.identifier, raw_gamepad.guid, Mappings.get_name (raw_gamepad.guid));
	}
}
