/**
 * A class to store the GUID of the gamepad.
 *
 * The GUID is a unique 128-bit identifier issued by the driver which is
 * dependent on the gamepad only and does not vary with time
 */
public class LibGamepad.Guid : Object {
	/**
	 * Raw GUID data : 128-bits stored as eight 16-bit unsigned integers
	 */
	public uint16[] guid { get; private set; default = new uint16[8]; }

	/**
	 * Create GUID from raw data
	 * @param  raw_guid      128-bits stored as eight 16-bit unsigned integers
	 */
	public Guid.from_data (uint16[] raw_guid) {
		for (var i = 0; i < 8; i++)
			guid[i] = raw_guid[i];
	}

	/**
	 * Creates GUID from the string representation of the guid
	 * @param  guidstr   The string from which the GUID has to be generated
	 */
	public Guid.parse (string guidstr) {
		for (var i = 0; i < 8; i++) {
			guid[i] = (asciitohex(guidstr[4*i + 2]) << 12) +
					  (asciitohex(guidstr[4*i + 3]) << 8) +
					  (asciitohex(guidstr[4*i + 0]) << 4) +
					  (asciitohex(guidstr[4*i + 1]) << 0) ;
		}
	}

	/**
	 * Serializes the GUID to a string
	 */
	public string to_string () {
		const string k_rgchHexToASCII = "0123456789abcdef";
	    var builder = new StringBuilder ();
	    for (var i = 0; i < 8; i++) {
	        uint8 c = (uint8) guid[i];

	        builder.append_unichar(k_rgchHexToASCII[c >> 4]);
	        builder.append_unichar(k_rgchHexToASCII[c & 0x0F]);

	        c = (uint8) (guid[i] >> 8);
	        builder.append_unichar(k_rgchHexToASCII[c >> 4]);
	        builder.append_unichar(k_rgchHexToASCII[c & 0x0F]);
	    }
		return builder.str;
	}

	private uint16 asciitohex (char ch) {
		if (ch >= '0' && ch <= '9') return ch - '0';
		else return ch - 'a' + 10;
	}
}
