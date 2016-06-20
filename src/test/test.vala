int main () {
	/*LibGamepad.Mappings.add_from_file(@"$(Constants.PKGDATADIR)/gamecontrollerdb.txt");*/
	/*print(@"$(Constants.PKGDATADIR)");*/
	var gm = new LibGamepad.GamepadMonitor();
	var g = new LibGamepad.Gamepad();
	gm.on_plugin.connect((guid, name) => {
		print(@"GM Plugged in $guid - $name\n");
		g.open(guid);
	});

	gm.on_unplug.connect((guid, name) => print (@"GM Unplugged $guid - $name\n"));

	gm.foreach_gamepad((guid, name) => {
		print(@"Initial plugged in $guid - $name\n");
		g.open (guid);
	});

	g.button_event.connect((button, value) => print(@"$(button.to_string()) - $value\n"));
	g.axis_event.connect((axis, value) => print(@"$(axis.to_string()) - $value\n"));
	g.unplug.connect(() => print("G Unplugged\n"));

	new MainLoop().run();
	return 0;
}
