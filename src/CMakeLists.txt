### CMakeLists automatically created with AutoVala
### Do not edit

set (DATADIR "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_DATAROOTDIR}")
set (PKGDATADIR "${DATADIR}/libgamepad")
set (GETTEXT_PACKAGE "libgamepad")
set (RELEASE_NAME "libgamepad")
set (CMAKE_C_FLAGS "")
set (PREFIX ${CMAKE_INSTALL_PREFIX})
set (VERSION "1.0.0")
set (TESTSRCDIR "${CMAKE_SOURCE_DIR}")
set (DOLLAR "$")

configure_file (${CMAKE_SOURCE_DIR}/src/Config.vala.cmake ${CMAKE_BINARY_DIR}/src/Config.vala)
add_definitions(-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\")
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/LibGamepad.pc ${CMAKE_CURRENT_BINARY_DIR}/LibGamepad.pc)
configure_file (${CMAKE_CURRENT_SOURCE_DIR}/LibGamepad.deps ${CMAKE_CURRENT_BINARY_DIR}/LibGamepad.deps)
set (VERSION "1.0.0")
add_definitions (${DEPS_CFLAGS})
link_libraries ( ${DEPS_LIBRARIES} )
link_directories ( ${DEPS_LIBRARY_DIRS} )
find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.32" MINIMUM)
include (ValaPrecompile)

set (VALA_PACKAGES ${VALA_PACKAGES} linux)
set (VALA_PACKAGES ${VALA_PACKAGES} posix)
set (VALA_PACKAGES ${VALA_PACKAGES} gudev-1.0)
set (VALA_PACKAGES ${VALA_PACKAGES} gio-2.0)
set (VALA_PACKAGES ${VALA_PACKAGES} glib-2.0)
set (VALA_PACKAGES ${VALA_PACKAGES} gobject-2.0)

set (APP_SOURCES ${APP_SOURCES} ${CMAKE_CURRENT_BINARY_DIR}/Config.vala)
set (APP_SOURCES ${APP_SOURCES} drivers/interface/raw-gamepad-monitor.vala)
set (APP_SOURCES ${APP_SOURCES} drivers/interface/raw-gamepad.vala)
set (APP_SOURCES ${APP_SOURCES} drivers/linux/guid-helpers.vala)
set (APP_SOURCES ${APP_SOURCES} drivers/linux/raw-gamepad-monitor.vala)
set (APP_SOURCES ${APP_SOURCES} drivers/linux/raw-gamepad.vala)
set (APP_SOURCES ${APP_SOURCES} gamepad-monitor.vala)
set (APP_SOURCES ${APP_SOURCES} gamepad.vala)
set (APP_SOURCES ${APP_SOURCES} helpers.vala)
set (APP_SOURCES ${APP_SOURCES} input-type.vala)
set (APP_SOURCES ${APP_SOURCES} mapping-error.vala)
set (APP_SOURCES ${APP_SOURCES} mapping-helpers.vala)
set (APP_SOURCES ${APP_SOURCES} mapping.vala)
set (APP_SOURCES ${APP_SOURCES} mappings-manager.vala)
set (APP_SOURCES ${APP_SOURCES} standard-gamepad-axis.vala)
set (APP_SOURCES ${APP_SOURCES} standard-gamepad-button.vala)

set (CUSTOM_VAPIS_LIST ${CUSTOM_VAPIS_LIST} ${CMAKE_SOURCE_DIR}/src/drivers/linux/vapis/libevdev.vapi)

set (COMPILE_OPTIONS ${COMPILE_OPTIONS} --library=LibGamepad --gir LibGamepad-1.0.gir )

vala_precompile(VALA_C LibGamepad
	${APP_SOURCES}
PACKAGES
	${VALA_PACKAGES}
CUSTOM_VAPIS
	${CUSTOM_VAPIS_LIST}
OPTIONS
	${COMPILE_OPTIONS}
GENERATE_VAPI
	LibGamepad
GENERATE_HEADER
	LibGamepad
)

add_library(LibGamepad SHARED ${VALA_C})

set_target_properties( LibGamepad PROPERTIES
VERSION
	1.0.0
SOVERSION
	1 )


install(TARGETS
	LibGamepad
LIBRARY DESTINATION
	${CMAKE_INSTALL_LIBDIR}/
)
install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/LibGamepad.h
DESTINATION
	${CMAKE_INSTALL_INCLUDEDIR}/
)
install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/LibGamepad.vapi
DESTINATION
	${CMAKE_INSTALL_DATAROOTDIR}/vala/vapi/
)
install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/LibGamepad.deps
DESTINATION
	${CMAKE_INSTALL_DATAROOTDIR}/vala/vapi/
)
install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/LibGamepad-1.0.gir
DESTINATION
	${CMAKE_INSTALL_DATAROOTDIR}/gir-1.0/
)
install(FILES
	${CMAKE_CURRENT_BINARY_DIR}/LibGamepad.pc
DESTINATION
	${CMAKE_INSTALL_LIBDIR}/pkgconfig/
)
if(HAVE_VALADOC)
	valadoc(LibGamepad
		${CMAKE_BINARY_DIR}/valadoc/LibGamepad
		${APP_SOURCES}
	PACKAGES
		${VALA_PACKAGES}
	CUSTOM_VAPIS
		${CUSTOM_VAPIS_LIST}
	)
	install(DIRECTORY
		${CMAKE_BINARY_DIR}/valadoc
	DESTINATION
		${CMAKE_INSTALL_DATAROOTDIR}/doc/libgamepad
	)
endif()

install(CODE "MESSAGE (\"
************************************************
* Run 'sudo ldconfig' to complete installation *
************************************************

\") " )