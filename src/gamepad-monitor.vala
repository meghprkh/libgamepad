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
	 * @param  identifier   The identifier of the plugged in gamepad
	 * @param  guid         The guid of the plugged in gamepad
	 * @param  name         The name of the plugged in gamepad
	 */
	public signal void on_plugin (string identifier, string guid, string? name);
	/**
	 * Emitted when a gamepad is unplugged
	 * @param  identifier    The identifier of the unplugged gamepad
	 * @param  guid          The guid of the unplugged gamepad
	 * @param  name          The name of the unplugged gamepad
	 */
	public signal void on_unplug (string identifier, string guid, string? name);

	public delegate void ForeachGamepadCallback(string identifier, string guid, string? name);
	/**
	 * This function allows to iterate over all gamepads
	 * @param    cb          The callback
	 */
	public void foreach_gamepad (ForeachGamepadCallback cb) {
		identifier_to_guid.foreach ((identifier, guid) => {
			var name = Mappings.get_name (guid);
			if (name == null) name = guid_to_raw_name.get (guid.to_string ());
			cb(identifier, guid, name);
		});
	}

	public GamepadMonitor() {
		init_static_if_not();

		gm = new LinuxRawGamepadMonitor ();

		gm.on_plugin.connect (on_raw_plugin);
		gm.on_unplug.connect (on_raw_unplug);

		string guid;
		string identifier;
		gm.foreach_gamepad((identifier, guid, raw_name) => {
			add_gamepad (identifier, guid, raw_name);
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
		else {
			var rg = new LinuxRawGamepad (identifier);
			return rg;
		}
	}

	private static HashTable<string, string> identifier_to_guid;
	private static HashTable<string, string> guid_to_identifier;
	private static HashTable<string, string> guid_to_raw_name;
	private RawGamepadMonitor gm;

	private static void init_static_if_not () {
		/*if (ngamepads == null) ngamepads = 0;*/
		if (identifier_to_guid == null)
			identifier_to_guid = new HashTable<string, string> (str_hash, str_equal);
		if (guid_to_identifier == null)
			guid_to_identifier = new HashTable<string, string> (str_hash, str_equal);
		if (guid_to_raw_name == null)
			guid_to_raw_name = new HashTable<string, string> (str_hash, str_equal);
	}

	private void add_gamepad (string identifier, string guid, string? raw_name) {
		ngamepads++;
		identifier_to_guid.replace (identifier, guid);
		guid_to_identifier.replace (guid.to_string (), identifier);
		guid_to_raw_name.replace (guid.to_string (), raw_name);
	}

	private void on_raw_plugin (string identifier, string guid, string? raw_name = null) {
		add_gamepad (identifier, guid, raw_name);
		var name = Mappings.get_name (guid);
		if (name == null) name = guid_to_raw_name.get (guid.to_string ());
		on_plugin (identifier, guid, name);
	}

	private void on_raw_unplug (string identifier) {
		var guid = identifier_to_guid.get (identifier);
		if (guid == null) return;
		ngamepads--;
		identifier_to_guid.remove (identifier);
		guid_to_identifier.remove (guid.to_string ());
		on_unplug (identifier, guid, Mappings.get_name (guid));
	}
}
