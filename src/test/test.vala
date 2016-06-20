int main () {
	/*LibGamepad.Mappings.add_from_file(@"$(Constants.PKGDATADIR)/gamecontrollerdb.txt");*/
	/*print(@"$(Constants.PKGDATADIR)");*/
	var gm = new LibGamepad.GamepadMonitor();
	LibGamepad.Gamepad? g = null;
	gm.on_plugin.connect((gp) => {
		print(@"GM Plugged in $(gp.raw_gamepad.identifier) - $(gp.guid) - $(gp.name)\n");
		g = gp;
		g.button_event.connect((button, value) => print(@"$(button.to_string()) - $value\n"));
		g.axis_event.connect((axis, value) => print(@"$(axis.to_string()) - $value\n"));
		g.unplug.connect(() => print("G Unplugged\n"));
	});

	gm.on_unplug.connect((identifier, guid, name) => print (@"GM Unplugged $identifier - $guid - $name\n"));

	gm.foreach_gamepad((gp) => {
		print(@"GM Plugged in $(gp.raw_gamepad.identifier) - $(gp.guid) - $(gp.name)\n");
		g = gp;
		g.button_event.connect((button, value) => print(@"$(button.to_string()) - $value\n"));
		g.axis_event.connect((axis, value) => print(@"$(axis.to_string()) - $value\n"));
		g.unplug.connect(() => print("G Unplugged\n"));
	});

	new MainLoop().run();
	return 0;
}
