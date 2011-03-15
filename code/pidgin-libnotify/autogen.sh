#!/bin/sh

(glib-gettextize --version) < /dev/null > /dev/null 2>&1 || {
	echo;
	echo "You must have gettext installed to compile pidgin-libnotify";
	echo;
	exit;
}

(libtoolize --version) < /dev/null > /dev/null 2>&1 || {
	echo;
	echo "You must have libtool installed to compile pidgin-libnotify";
	echo;
	exit;
}

(automake --version) < /dev/null > /dev/null 2>&1 || {
	echo;
	echo "You must have automake installed to compile pidgin-libnotify";
	echo;
	exit;
}

(autoconf --version) < /dev/null > /dev/null 2>&1 || {
	echo;
	echo "You must have autoconf installed to compile pidgin-libnotify";
	echo;
	exit;
}

echo "Generating configuration files for pidgin-libnotify, please wait...."
echo;

# Backup po/ChangeLog because gettext likes to change it
cp -p po/ChangeLog po/ChangeLog.save

echo "Running gettextize, please ignore non-fatal messages...."
glib-gettextize --force --copy

#restore pl/ChangeLog
mv po/ChangeLog.save po/ChangeLog

echo "Running libtoolize, please ignore non-fatal messages...."
echo n | libtoolize --copy --force || exit;
echo;

aclocal || exit;
autoheader || exit;
automake --add-missing --copy;
autoconf || exit;
automake || exit;

echo "Running ./configure $@"
echo;
./configure $@

