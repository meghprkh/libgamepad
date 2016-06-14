private class LibGamepad.LinuxGuidHelpers : Object {
	public static Guid from_dev (Libevdev.Evdev dev) {
		uint16[] guid = new uint16[8];
		guid[0] = dev.id_bustype.to_little_endian ();
	    guid[1] = 0;
		guid[2] = dev.id_vendor.to_little_endian ();
	    guid[3] = 0;
		guid[4] = dev.id_product.to_little_endian ();
	    guid[5] = 0;
		guid[6] = dev.id_version.to_little_endian ();
	    guid[7] = 0;
		return new Guid.from_data(guid);
	}

	public static Guid from_file (string file_name) throws FileError {
	   	var fd = Posix.open (file_name, Posix.O_RDONLY | Posix.O_NONBLOCK);

	   	if (fd < 0)
	   		throw new FileError.FAILED (@"Unable to open file $file_name: $(Posix.strerror(Posix.errno))");

	   	var dev = new Libevdev.Evdev();
	   	if (dev.set_fd(fd) < 0)
	   		throw new FileError.FAILED (@"Evdev error on opening file $file_name: $(Posix.strerror(Posix.errno))");

		Guid guid = from_dev (dev);
		Posix.close(fd);
		return guid;
	}
}
