#!/usr/bin/env python
import email
import re
import time
from pathlib import Path
from typing import Any

import gi

gi.require_version("Notify", "0.7")
from gi.repository import Notify

from watchdog.events import FileSystemEventHandler, LoggingEventHandler
from watchdog.observers import Observer

MAILDIR = Path("~/Mail").expanduser()
ICON_PATH = "/usr/share/icons/Yaru/48x48/apps/mail-app.png"

Notify.init("Mail Notification Daemon")


class MailWatchDaemon(FileSystemEventHandler):
    metadata_re = re.compile(".*\.mbsyncstate\..*$")
    from_re = re.compile("(.*)<.*@.*>")

    def esc(self, string: str) -> str:
        return string.replace("<", "&lt;").replace(">", "&gt;")

    def on_created(self, event):
        try:
            self._do_on_created(event)
        except Exception as e:
            print("ERROR", e)

    def _do_on_created(self, event):
        mail_path = event.src_path
        if self.metadata_re.match(mail_path):
            return

        if "INBOX" not in mail_path:
            return

        with open(mail_path) as f:
            message = email.message_from_file(f)

        from_address = message.get("from")
        to_address = message.get("delivered-to")
        subject = message.get("subject", "<NO SUBJECT>")

        message_content = None
        for payload in message.get_payload():
            if isinstance(payload, email.message.Message):
                content_type = payload.get_content_type()
                if "encrypted" in content_type:
                    message_content = ["<encrypted message>"]
                elif content_type == "text/plain":
                    non_empty_lines = filter(
                        len, payload.get_payload().strip().split("\n")
                    )
                    message_content = list(non_empty_lines)[:3]

        if match := self.from_re.fullmatch(from_address):
            from_address = match.group(1)

        print(f"Recieved message from {from_address}")
        print(f"To {to_address}")
        print(f"With subject {subject}")

        notification = Notify.Notification.new(
            self.esc(from_address),
            "\n".join([self.esc(subject), *map(self.esc, message_content)]),
            ICON_PATH,
        )
        notification.set_timeout(10000)
        notification.show()


daemon = MailWatchDaemon()
observer = Observer()
observer.schedule(daemon, str(MAILDIR.absolute()), recursive=True)
observer.start()

try:
    while True:
        time.sleep(1)
except KeyboardInterrupt:
    observer.stop()

observer.join()
Notify.uninit()
