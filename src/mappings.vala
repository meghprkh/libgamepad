/**
 * This class gives methods to set/update the mappings
 *
 * The client interfaces with this class primarily
 */
public class LibGamepad.Mappings {
	private static HashTable<string, string> names;
	private static HashTable<string, string> mappings;

	private static bool? inited;
	private static void init_if_not () {
		if (inited == null || inited == false) {
			inited = true;
			if (names == null)
				names = new HashTable<string, string> (str_hash, str_equal);
			if (mappings == null)
				mappings = new HashTable<string, string> (str_hash, str_equal);
			Mappings.add_from_file (@"$(LibGamepadConstants.PKGDATADIR)/gamecontrollerdb.txt");
		}
	}


	/**
	 * Adds mappings from a file
	 * @param file_name          The file name
	 */
	public static void add_from_file (string file_name) throws IOError {
		init_if_not ();

		var f = File.new_for_path(file_name);
		add_from_input_stream (f.read());
	}

	/**
	 * Adds mappings from a resource path
	 * @param path          The path
	 */
	public static void add_from_resource (string path) throws IOError {
		init_if_not ();

		add_from_input_stream (resources_open_stream (path, ResourceLookupFlags.NONE));
	}

	/**
	 * Adds mappings from an InputStream
	 * @param input_stream          The input stream
	 */
	public static void add_from_input_stream (InputStream input_stream) {
		init_if_not ();

		var ds = new DataInputStream (input_stream);
		var str = ds.read_line();
		while (str != null) {
			add_mapping(str);
			str = ds.read_line ();
		}
	}


	/**
	 * Adds a mapping from a string (only one gamepad)
	 */
	public static void add_mapping (string str) {
		init_if_not ();

		if (str == "" || str[0] == '#')
			return;

		if (str.index_of ("platform") == -1 || str.index_of ("platform:Linux") != -1) {
			var split = str.split(",", 3);
			names.replace(split[0], split[1]);
			mappings.replace(split[0], split[2]);
		}
	}


	/**
	 * Gets the name of a gamepad from the database
	 * @param  guid          The guid of the wanted gamepad
	 * @return The name if present in the database
	 */
	public static string? get_name (string guid) {
		init_if_not ();
		return names.get(guid);
	}


	/**
	 * Gets the current mapping from the databse
	 * @param  guid          The guid of the wanted gamepad
	 * @return The mapping if present in the database
	 */
	public static string? get_mapping (string guid) {
		init_if_not ();
		return mappings.get(guid);
	}
}
