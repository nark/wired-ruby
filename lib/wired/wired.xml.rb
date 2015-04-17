$xmlspec = '<?xml version="1.0" encoding="UTF-8"?>
<p7:protocol xmlns:p7="http://www.read-write.fr/wired/html/wired.html"
			 xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			 xsi:schemaLocation="http://www.read-write.fr/wired/html/p7-specification.xsd"
			 name="Wired"
			 version="2.0b55">
	<p7:documentation>
		TBD
		
		...
		
		[a note on differences from Wired 1.1]
		
		...
		
		[a note on account permissions]
		
		...
		
		[a note on file permissions]
		
		...
		
		[a note on transfers]
	</p7:documentation>
	
	<p7:fields>
		<p7:field name="wired.transaction" type="uint32" id="1000" version="2.0">
			<p7:documentation>
				A number acting as a transaction counter. This field is treated specially in that
				if it is set in a message, all messages that are a reply to that message should
				have this field set to the identical value. It is present, but optional in all
				messages that take part in transactions. It is recommended that this be incremented
				from its initial value for each new message sent, so that replies can be separated.
			</p7:documentation>
		</p7:field>

		<p7:field name="wired.error" type="enum" id="1001" version="2.0">
			<p7:documentation>
				Enumeration of all the errors that can occur.
			</p7:documentation>
			<p7:enum name="wired.error.internal_error" value="0" version="2.0" />
			<p7:enum name="wired.error.invalid_message" value="1" version="2.0" />
			<p7:enum name="wired.error.unrecognized_message" value="2" version="2.0" />
			<p7:enum name="wired.error.message_out_of_sequence" value="3" version="2.0" />
			<p7:enum name="wired.error.login_failed" value="4" version="2.0" />
			<p7:enum name="wired.error.permission_denied" value="5" version="2.0" />
			<p7:enum name="wired.error.not_subscribed" value="6" version="2.0" />
			<p7:enum name="wired.error.already_subscribed" value="7" version="2.0" />
			<p7:enum name="wired.error.chat_not_found" value="8" version="2.0" />
			<p7:enum name="wired.error.already_on_chat" value="9" version="2.0" />
			<p7:enum name="wired.error.not_on_chat" value="10" version="2.0" />
			<p7:enum name="wired.error.not_invited_to_chat" value="11" version="2.0" />
			<p7:enum name="wired.error.user_not_found" value="12" version="2.0" />
			<p7:enum name="wired.error.user_cannot_be_disconnected" value="13" version="2.0" />
			<p7:enum name="wired.error.file_not_found" value="14" version="2.0" />
			<p7:enum name="wired.error.file_exists" value="15" version="2.0" />
			<p7:enum name="wired.error.account_not_found" value="16" version="2.0" />
			<p7:enum name="wired.error.account_exists" value="17" version="2.0" />
			<p7:enum name="wired.error.account_in_use" value="18" version="2.0" />
			<p7:enum name="wired.error.tracker_not_enabled" value="19" version="2.0" />
			<p7:enum name="wired.error.not_registered" value="20" version="2.0" />
			<p7:enum name="wired.error.ban_not_found" value="21" version="2.0" />
			<p7:enum name="wired.error.ban_exists" value="22" version="2.0" />
			<p7:enum name="wired.error.board_not_found" value="23" version="2.0" />
			<p7:enum name="wired.error.board_exists" value="24" version="2.0" />
			<p7:enum name="wired.error.thread_not_found" value="25" version="2.0" />
			<p7:enum name="wired.error.post_not_found" value="26" version="2.0" />
			<p7:enum name="wired.error.rsrc_not_supported" value="27" version="2.0" />
		</p7:field>
		
		<p7:field name="wired.error.string" type="string" id="1002" version="2.0">
			<p7:documentation>
				Additional error information as a string.
			</p7:documentation>
		</p7:field>

		<p7:field name="wired.info.application.name" type="string" id="2000" version="2.0">
			<p7:documentation>
				Application name, e.g. "Wired Client".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.application.version" type="string" id="2001" version="2.0">
			<p7:documentation>
				Application version, e.g. "1.0".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.application.build" type="string" id="2002" version="2.0">
			<p7:documentation>
				Application build, e.g. 0xEEEEEEEE (git commit hash).
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.os.name" type="string" id="2003" version="2.0">
			<p7:documentation>
				Operating system name, e.g. "Mac OS X".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.os.version" type="string" id="2004" version="2.0">
			<p7:documentation>
				Operation system version, e.g. "10.5".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.arch" type="string" id="2005" version="2.0">
			<p7:documentation>
				System architecture name, e.g. "i386".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.supports_rsrc" type="bool" id="2006" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.name" type="string" id="2008" version="2.0">
			<p7:documentation>
				Server name from configuration.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.description" type="string" id="2009" version="2.0">
			<p7:documentation>
				Server description from configuration.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.start_time" type="date" id="2010" version="2.0">
			<p7:documentation>
				The time the server was started, i.e. its uptime.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.files.count" type="uint64" id="2011" version="2.0">
			<p7:documentation>
				The number of files the server is sharing.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.files.size" type="uint64" id="2012" version="2.0">
			<p7:documentation>
				The size of the files the server is sharing.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.banner" type="data" id="2013" version="2.0">
			<p7:documentation>
				Server banner as image data. The image format should be PNG, and the icon dimensions
				should not exceed 200x32 pixels.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.downloads" type="uint32" id="2014" version="2.0">
			<p7:documentation>
				The global limit on the number of download transfers, from configuration. 0 means unlimited.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.uploads" type="uint32" id="2015" version="2.0">
			<p7:documentation>
				The global limit on the number of upload transfers, from configuration. 0 means unlimited.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.download_speed" type="uint32" id="2016" version="2.0">
			<p7:documentation>
				The global limit on the download transfer speed in bytes/second, from configuration. 0 means unlimited.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.info.upload_speed" type="uint32" id="2017" version="2.0">
			<p7:documentation>
				The global limit on the upload transfer speed in bytes/second, from configuration. 0 means unlimited.
			</p7:documentation>
		</p7:field>
		
		<p7:field name="wired.user.id" type="uint32" id="3000" version="2.0">
			<p7:documentation>
				Identification number of a user. Unique across all users.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.idle" type="bool" id="3001" version="2.0">
			<p7:documentation>
				Should be set to true if the user has indicated it with the [message:wired.user.set_idle]
				message, or alternatively, if the user has been inactive for an application-defined
				length of time. Inactive in this context means that the user has not sent any message
				other than [message:wired.send_ping].
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.nick" type="string" id="3002" version="2.0">
			<p7:documentation>
				Nick name of a user. This is not guaranteed to be unique across all users.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.login" type="string" id="3003" version="2.0">
			<p7:documentation>
				Login name of a user. This is the same as [field:wired.account.name] for user
				accounts, but used for logins.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.password" type="string" id="3004" version="2.0">
			<p7:documentation>
				Password of a user. This is the same as [field:wired.account.password], but used
				for logins. The string should be the hexadecimal representation of the SHA-1 hash of
				the actual password. This should be the case even if the actual password is empty.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.status" type="string" id="3005" version="2.0">
			<p7:documentation>
				Status of a user.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.icon" type="data" id="3006" version="2.0">
			<p7:documentation>
				User icon as image data. The image format should be PNG, and the icon dimensions
				should not exceed 32x32 pixels.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.ip" type="string" id="3007" version="2.0">
			<p7:documentation>
				IP address of a user. Should be set to the string representation of either an IPv4
				address, e.g. "127.0.0.1", or an IPv6 address, e.g. "::1".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.host" type="string" id="3008" version="2.0">
			<p7:documentation>
				Host name of the user. Should be resolved by the server, and set to the empty string
				if resolution fails.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.cipher.name" type="string" id="3009" version="2.0">
			<p7:documentation>
				Name of the cipher, e.g. "AES", used by the underlying protocol, if any. 
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.cipher.bits" type="uint32" id="3010" version="2.0">
			<p7:documentation>
				Number of bits, e.g. 256, used by the cipher for its key in the underlying protocol, if any.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.login_time" type="date" id="3011" version="2.0">
			<p7:documentation>
				Time of login of the user.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.idle_time" type="date" id="3012" version="2.0">
			<p7:documentation>
				Time of last activity of the user. See [field:wired.user.idle] for details on when this is
				reset.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.disconnect_message" type="string" id="3013" version="2.0">
			<p7:documentation>
				User-given message when that user forcibly parts another user (i.e. disconnects, kicks or bans).
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.disconnected_id" type="uint32" id="3014" version="2.0">
			<p7:documentation>
				Same as [field:wired.user.id] but used when one user forcibly parts another user (i.e. disconnects,
				kicks or bans).
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.user.state" type="enum" id="3015" version="2.0">
			<p7:documentation>
				State of the user. [enum:wired.user.state.connected] means that the user has just logged
				in but not sent [message:wired.send_login] yet. [enum:wired.user.state.logging_in] means
				that the user has sent [message:wired.send_login] and is waiting for the server.
				[enum:wired.user.state.logged_in] means that the user is logged in.
				[enum:wired.user.state.transferring] means that the user is currently transferring a file.
				[enum:wired.user.sate.disconnecting] means that the user is disconnecting from the server.
			</p7:documentation>
			<p7:enum name="wired.user.state.connected" value="0" version="2.0" />
			<p7:enum name="wired.user.state.logging_in" value="1" version="2.0" />
			<p7:enum name="wired.user.state.logged_in" value="2" version="2.0" />
			<p7:enum name="wired.user.state.transferring" value="3" version="2.0" />
			<p7:enum name="wired.user.state.disconnecting" value="4" version="2.0" />
		</p7:field>

		<p7:field name="wired.chat.id" type="uint32" id="4000" version="2.0">
			<p7:documentation>
				Identification number of a chat. This number should be created when each chat is
				created, and be unique across all chats. The chat ID 1 identifies the public chat.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.chat.topic.topic" type="string" id="4001" version="2.0">
			<p7:documentation>
				Topic of the chat.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.chat.topic.time" type="date" id="4002" version="2.0">
			<p7:documentation>
				Time when the topic was set.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.chat.say" type="string" id="4003" version="2.0">
			<p7:documentation>
				A normal chat message, i.e. one formatted similar to "user: hello".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.chat.me" type="string" id="4004" version="2.0">
			<p7:documentation>
				An action chat message, i.e. one formatted similar to "user says hello".
			</p7:documentation>
		</p7:field>

		<p7:field name="wired.message.message" type="string" id="5000" version="2.0">
			<p7:documentation>
				A private message.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.message.broadcast" type="string" id="5001" version="2.0">
			<p7:documentation>
				A public broadcast message.
			</p7:documentation>
		</p7:field>

		<p7:field name="wired.board.board" type="string" id="6000" version="2.0">
			<p7:documentation>
				Path of a board. Board paths are similar to file system paths, and are separated by
				slashes, i.e. "/". Unlike a file system, however, there is no leading slash for root boards.
				As an example, a board at the root level may be called "Foo", and [field:wired.board.board]
				should then be "Foo" as well. A board that is a child of this board may be called "Bar",
				and [field:wired.board.board] should then be "Foo/Bar".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.new_board" type="string" id="6001" version="2.0">
			<p7:documentation>
				Same as [field:wired.board.board], but used when moving or renaming boards.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.thread" type="uuid" id="6002" version="2.0">
			<p7:documentation>
				Identifier of a thread on a board.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.post" type="uuid" id="6003" version="2.0">
			<p7:documentation>
				Identifier of a post in a thread.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.post_date" type="date" id="6004" version="2.0">
			<p7:documentation>
				Date when the post was created.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.edit_date" type="date" id="6005" version="2.0">
			<p7:documentation>
				Date when the post was last edited.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.subject" type="string" id="6006" version="2.0">
			<p7:documentation>
				Subject of a post.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.text" type="string" id="6007" version="2.0">
			<p7:documentation>
				Text of a post.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.owner" type="string" id="6008" version="2.0">
			<p7:documentation>
				Same as [field:wired.account.name] but used for board permissions.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.owner.read" type="bool" id="6009" version="2.0">
			<p7:documentation>
				Indicates whether the owner can read threads and posts on the board.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.owner.write" type="bool" id="6010" version="2.0">
			<p7:documentation>
				Indicates whether the owner can post threads and posts on the board.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.group" type="string" id="6011" version="2.0">
			<p7:documentation>
				Same as [field:wired.account.group] but used for board permissions.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.group.read" type="bool" id="6012" version="2.0">
			<p7:documentation>
				Indicates whether the members of the group can read threads and posts on the board.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.group.write" type="bool" id="6013" version="2.0">
			<p7:documentation>
				Indicates whether the members of the group can post threads and posts on the board.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.everyone.read" type="bool" id="6014" version="2.0">
			<p7:documentation>
				Indicates whether everyone can read threads and posts on the board.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.everyone.write" type="bool" id="6015" version="2.0">
			<p7:documentation>
				Indicates whether everyone can post threads and posts on the board.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.readable" type="bool" id="6016" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.writable" type="bool" id="6017" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.own_thread" type="bool" id="6018" version="2.0">
			<p7:documentation>
				Indicates whether the thread was created by the currently logged in account.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.replies" type="uint32" id="6019" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.latest_reply" type="uuid" id="6020" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.latest_reply_date" type="date" id="6021" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.board.own_post" type="bool" id="6022" version="2.0">
			<p7:documentation>
				Indicates whether the post was created by the currently logged in account.
			</p7:documentation>
		</p7:field>

		<p7:field name="wired.file.path" type="string" id="7000" version="2.0">
			<p7:documentation>
				Path to a file, separated by slashes, i.e. "/". The root directory is a single slash,
				i.e. "/".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.type" type="enum" id="7001" version="2.0">
			<p7:documentation>
				File type. [enum:wired.file.type.file] indicates a normal file, and
				[enum:wired.file.type.directory] indicates a normal directory. The other two are specific
				to Wired, and are differentiated mostly by permissions. [enum:wired.file.type.uploads]
				are directories that may be uploaded into, and listed, while [enum:wired.file.type.dropbox]
				may be uploaded into, but not listed. Drop boxes can also have extended permissions, like
				[field:wired.file.owner], etc.
			</p7:documentation>
			<p7:enum name="wired.file.type.file" value="0" version="2.0" />
			<p7:enum name="wired.file.type.directory" value="1" version="2.0" />
			<p7:enum name="wired.file.type.uploads" value="2" version="2.0" />
			<p7:enum name="wired.file.type.dropbox" value="3" version="2.0" />
		</p7:field>
		<p7:field name="wired.file.data_size" type="uint64" id="7002" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.rsrc_size" type="uint64" id="7003" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.directory_count" type="uint32" id="7004" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.creation_time" type="date" id="7005" version="2.0">
			<p7:documentation>
				Date when the file was created.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.modification_time" type="date" id="7006" version="2.0">
			<p7:documentation>
				Date when the file was last modified.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.comment" type="string" id="7007" version="2.0">
			<p7:documentation>
				Comment of the file.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.recursive" type="bool" id="7008" version="2.0">
			<p7:documentation>
				Indicates whether certain files requests should be recursive.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.available" type="uint64" id="7009" version="2.0">
			<p7:documentation>
				Number of bytes of free disk space.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.new_path" type="string" id="7010" version="2.0">
			<p7:documentation>
				Same as [field:wired.file.path], but used when renaming or moving files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.query" type="string" id="7011" version="2.0">
			<p7:documentation>
				Query for file searches.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.link" type="bool" id="7012" version="2.0">
			<p7:documentation>
				Indicates whether a file is a link (or alias, shortcut, etc). This may be true for
				any file type.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.executable" type="bool" id="7013" version="2.0">
			<p7:documentation>
				Indicates whether a file is executable. This may only be true for files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.owner" type="string" id="7014" version="2.0">
			<p7:documentation>
				Same as [field:wired.account.name] but used for file permissions.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.owner.read" type="bool" id="7015" version="2.0">
			<p7:documentation>
				Indicates whether the owner can list and read files in the directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.owner.write" type="bool" id="7016" version="2.0">
			<p7:documentation>
				Indicates whether the owner can upload and modify files in the directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.group" type="string" id="7017" version="2.0">
			<p7:documentation>
				Same as [field:wired.account.group] but used for file permissions.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.group.read" type="bool" id="7018" version="2.0">
			<p7:documentation>
				Indicates whether members of the group can list and read files in the directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.group.write" type="bool" id="7019" version="2.0">
			<p7:documentation>
				Indicates whether members of the group can upload and modify files in the directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.everyone.read" type="bool" id="7020" version="2.0">
			<p7:documentation>
				Indicates whether everyone can list and read files in the directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.everyone.write" type="bool" id="7021" version="2.0">
			<p7:documentation>
				Indicates whether everyone can upload and modify files in the directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.label" type="enum" id="7022" version="2.0">
			<p7:documentation>
				Label of a file. This may be set for any file type.
			</p7:documentation>
			<p7:enum name="wired.file.label.none" value="0" version="2.0" />
			<p7:enum name="wired.file.label.red" value="1" version="2.0" />
			<p7:enum name="wired.file.label.orange" value="2" version="2.0" />
			<p7:enum name="wired.file.label.yellow" value="3" version="2.0" />
			<p7:enum name="wired.file.label.green" value="4" version="2.0" />
			<p7:enum name="wired.file.label.blue" value="5" version="2.0" />
			<p7:enum name="wired.file.label.purple" value="6" version="2.0" />
			<p7:enum name="wired.file.label.gray" value="7" version="2.0" />
		</p7:field>
		<p7:field name="wired.file.volume" type="uint32" id="7023" version="2.0">
			<p7:documentation>
				An application-defined identifier of the volume the file resides on. This may be set
				for any file type. Can be used by clients to determine whether [message:wired.file.move]
				will cause the file to be moved, or to be copied.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.readable" type="bool" id="7024" version="2.0">
			<p7:documentation>
				Indicates whether the currently logged in account can list and read files in the
				directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.writable" type="bool" id="7025" version="2.0">
			<p7:documentation>
				Indicates whether the currently logged in account can upload and modify files in the
				directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.file.preview" type="data" id="7026" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>

		<p7:field name="wired.account.name" type="string" id="8000" version="2.0">
			<p7:documentation>
				Name of an account.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.new_name" type="string" id="8001" version="2.0">
			<p7:documentation>
				Same as [field:wired.account.name] but used when renaming.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.disconnect_users" type="bool" id="8002" version="2.0">
			<p7:documentation>
				Indicates that users currently logged in using an account should be disconnected
				when the account is deleted.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.full_name" type="string" id="8003" version="2.0">
			<p7:documentation>
				Full name of an account.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.comment" type="string" id="8004" version="2.0">
			<p7:documentation>
				Comment on an account.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.color" type="enum" id="8005" version="2.0">
			<p7:documentation>
				Color for an account.
			</p7:documentation>
			<p7:enum name="wired.account.color.black" value="0" version="2.0" />
			<p7:enum name="wired.account.color.red" value="1" version="2.0" />
			<p7:enum name="wired.account.color.orange" value="2" version="2.0" />
			<p7:enum name="wired.account.color.green" value="3" version="2.0" />
			<p7:enum name="wired.account.color.blue" value="4" version="2.0" />
			<p7:enum name="wired.account.color.purple" value="5" version="2.0" />
		</p7:field>
		<p7:field name="wired.account.creation_time" type="date" id="8006" version="2.0">
			<p7:documentation>
				Date when the account was created.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.modification_time" type="date" id="8007" version="2.0">
			<p7:documentation>
				Date when the account was last modified.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.login_time" type="date" id="8008" version="2.0">
			<p7:documentation>
				Date when the account was last logged in.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.edited_by" type="string" id="8009" version="2.0">
			<p7:documentation>
				Nick name of user who creator or last edited the account. Like [field:wired.user.nick].
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.downloads" type="uint32" id="8010" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.download_transferred" type="uint64" id="8011" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.uploads" type="uint32" id="8012" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.upload_transferred" type="uint64" id="8013" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.password" type="string" id="8014" version="2.0">
			<p7:documentation>
				Password of an account. The string should be the hexadecimal representation of the SHA-1
				hash of the actual password.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.group" type="string" id="8015" version="2.0">
			<p7:documentation>
				Primary group name of a user account. If this is set, privileges from the group account
				should override those from the user account.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.groups" type="list" listtype="string" id="8016" version="2.0">
			<p7:documentation>
				Secondary group names of a user account. These should not be used for account privileges,
				but rather for permissions on files and boards.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.files" type="string" id="8017" version="2.0">
			<p7:documentation>
				Path within the files area that should be accessible to the account.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.user.cannot_set_nick" type="bool" id="8018" version="2.0">
			<p7:documentation>
				Indicates whether the account cannot change its nick name.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.user.get_info" type="bool" id="8019" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to get info of other users.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.user.disconnect_users" type="bool" id="8020" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to disconnect other users.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.user.ban_users" type="bool" id="8021" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to ban other users.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.user.cannot_be_disconnected" type="bool" id="8022" version="2.0">
			<p7:documentation>
				Indicates whether the account cannot be disconnected (i.e. disconnected, kicked or banned).
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.user.get_users" type="bool" id="8023" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to get a list of all users currently
				logged in.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.chat.kick_users" type="bool" id="8024" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to kick other users.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.chat.set_topic" type="bool" id="8025" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to set the topic of the public chat.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.chat.create_chats" type="bool" id="8026" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to create new chats.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.message.send_messages" type="bool" id="8027" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to send private messages to other users.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.message.broadcast" type="bool" id="8028" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege to broadcast messages to all users currently
				logged in.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.read_boards" type="bool" id="8029" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of reading boards.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.add_boards" type="bool" id="8030" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating boards.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.move_boards" type="bool" id="8031" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of moving boards.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.rename_boards" type="bool" id="8032" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of renaming boards.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.delete_boards" type="bool" id="8033" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of deleting boards.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.get_board_info" type="bool" id="8034" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of change board permissions.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.set_board_info" type="bool" id="8035" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of change board permissions.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.add_threads" type="bool" id="8036" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating new threads.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.move_threads" type="bool" id="8037" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of moving threads.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.add_posts" type="bool" id="8038" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating new posts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.edit_own_threads_and_posts" type="bool" id="8039" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of editing own threads and posts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.edit_all_threads_and_posts" type="bool" id="8040" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of editing all threads and posts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.delete_own_threads_and_posts" type="bool" id="8041" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of deleting own threads and posts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.board.delete_all_threads_and_posts" type="bool" id="8042" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of deleting all threads and posts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.list_files" type="bool" id="8043" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of listing files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.get_info" type="bool" id="8044" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of getting file info.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.search_files" type="bool" id="8045" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of search files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.create_directories" type="bool" id="8046" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating new directories.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.create_links" type="bool" id="8047" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating new file links.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.move_files" type="bool" id="8048" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of moving files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.rename_files" type="bool" id="8049" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of renaming files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.set_type" type="bool" id="8050" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of changing file types.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.set_comment" type="bool" id="8051" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of changing file comments.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.set_permissions" type="bool" id="8052" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of changing file permissions.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.set_executable" type="bool" id="8053" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of changing file executable flags.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.set_label" type="bool" id="8054" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of changing file labels.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.delete_files" type="bool" id="8055" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of deleting files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.access_all_dropboxes" type="bool" id="8056" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of accessing all drop boxes.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.file.recursive_list_depth_limit" type="uint32" id="8057" version="2.0">
			<p7:documentation>
				Indicates the limit on the directory depth the account gives for recursive file
				operations. 0 means no limit.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.download_files" type="bool" id="8058" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of downloading files.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.upload_files" type="bool" id="8059" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of uploading new files in upload
				directories and drop boxes.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.upload_directories" type="bool" id="8060" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of uploading new directories in
				upload directories and drop boxes.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.upload_anywhere" type="bool" id="8061" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of uploading new files or directories
				in any directory.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.download_limit" type="uint32" id="8062" version="2.0">
			<p7:documentation>
				Indicates the limit on the number of simultaneous download transfers the account gives.
				0 means no limit.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.upload_limit" type="uint32" id="8063" version="2.0">
			<p7:documentation>
				Indicates the limit on the number of simultaneous upload transfers the account gives.
				0 means no limit.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.download_speed_limit" type="uint32" id="8064" version="2.0">
			<p7:documentation>
				Indicates the combined limit in speed in bytes/second for all download transfers
				the account gives. 0 means no limit.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.transfer.upload_speed_limit" type="uint32" id="8065" version="2.0">
			<p7:documentation>
				Indicates the combined limit in speed in bytes/second for all upload transfers
				the account gives. 0 means no limit.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.change_password" type="bool" id="8066" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of changing the password.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.list_accounts" type="bool" id="8067" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of listing other accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.read_accounts" type="bool" id="8068" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of reading other accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.create_users" type="bool" id="8069" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating new user accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.edit_users" type="bool" id="8070" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of editing user accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.delete_users" type="bool" id="8071" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of deleting user accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.create_groups" type="bool" id="8072" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating new group accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.edit_groups" type="bool" id="8073" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of editing group accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.delete_groups" type="bool" id="8074" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of deleting group accounts.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.account.raise_account_privileges" type="bool" id="8075" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of creating or editing accounts
				to give them more privileges or higher limits than itself has.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.log.view_log" type="bool" id="8076" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of viewing the log.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.events.view_events" type="bool" id="8077" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of viewing events.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.settings.get_settings" type="bool" id="8078" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of reading the server configuration.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.settings.set_settings" type="bool" id="8079" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of changing the server configuration.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.banlist.get_bans" type="bool" id="8080" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of reading the server banlist.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.banlist.add_bans" type="bool" id="8081" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of adding bans to the server banlist.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.banlist.delete_bans" type="bool" id="8082" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of removing bans from the server banlist.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.tracker.list_servers" type="bool" id="8083" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of listing other servers.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.account.tracker.register_servers" type="bool" id="8084" version="2.0">
			<p7:documentation>
				Indicates whether the account gives the privilege of registering other servers.
			</p7:documentation>
		</p7:field>

		<p7:field name="wired.transfer.type" type="enum" id="9000" version="2.0">
			<p7:documentation>
				Type of a transfer. [enum:wired.transfer.type.download] is a download transfers, while
				[enum:wired.transfer.type.upload] is an upload transfer.
			</p7:documentation>
			<p7:enum name="wired.transfer.type.download" value="0" version="2.0" />
			<p7:enum name="wired.transfer.type.upload" value="1" version="2.0" />
		</p7:field>
		<p7:field name="wired.transfer.data_size" type="uint64" id="9001" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.rsrc_size" type="uint64" id="9002" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.data_offset" type="uint64" id="9003" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.rsrc_offset" type="uint64" id="9004" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.finderinfo" type="data" id="9005" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.queue_position" type="uint32" id="9006" version="2.0">
			<p7:documentation>
				Position in the server queue of a transfer.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.data" type="oobdata" id="9007" version="2.0">
			<p7:documentation>
				Data of a transfer.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.rsrc" type="oobdata" id="9008" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.transferred" type="uint64" id="9009" version="2.0">
			<p7:documentation>
				Number of bytes transferred so far for a transfer.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.transfer.speed" type="uint32" id="9010" version="2.0">
			<p7:documentation>
				Current speed in bytes/second for a transfer.
			</p7:documentation>
		</p7:field>
		
		<p7:field name="wired.log.time" type="date" id="10000" version="2.0">
			<p7:documentation>
				Date of a log entry.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.log.level" type="enum" id="10001" version="2.0">
			<p7:documentation>
				Level of a log entry. [enum:wired.log.debug] is a debug log message, [enum:wired.log.info]
				is an informational log message, [enum:wired.log.warning] is a warning log message and
				[wired.log.error] is an error log message.
			</p7:documentation>
			<p7:enum name="wired.log.debug" value="0" version="2.0" />
			<p7:enum name="wired.log.info" value="1" version="2.0" />
			<p7:enum name="wired.log.warning" value="2" version="2.0" />
			<p7:enum name="wired.log.error" value="3" version="2.0" />
		</p7:field>
		<p7:field name="wired.log.message" type="string" id="10002" version="2.0">
			<p7:documentation>
				Message of a log entry.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.event.first_time" type="date" id="10003" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.event.from_time" type="date" id="10004" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.event.to_time" type="date" id="10050" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.event.number_of_days" type="uint32" id="10005" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.event.last_event_count" type="uint32" id="10006" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.event.event" type="enum" id="10007" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:enum name="wired.event.user.logged_in" value="0" version="2.0" />
			<p7:enum name="wired.event.user.login_failed" value="1" version="2.0" />
			<p7:enum name="wired.event.user.logged_out" value="2" version="2.0" />
			<p7:enum name="wired.event.user.changed_nick" value="3" version="2.0" />
			<p7:enum name="wired.event.user.got_info" value="4" version="2.0" />
			<p7:enum name="wired.event.user.disconnected_user" value="5" version="2.0" />
			<p7:enum name="wired.event.user.banned_user" value="6" version="2.0" />
			<p7:enum name="wired.event.user.got_users" value="7" version="2.0" />
			<p7:enum name="wired.event.file.listed_directory" value="8" version="2.0" />
			<p7:enum name="wired.event.file.got_info" value="9" version="2.0" />
			<p7:enum name="wired.event.file.moved" value="10" version="2.0" />
			<p7:enum name="wired.event.file.linked" value="11" version="2.0" />
			<p7:enum name="wired.event.file.set_type" value="12" version="2.0" />
			<p7:enum name="wired.event.file.set_comment" value="13" version="2.0" />
			<p7:enum name="wired.event.file.set_executable" value="14" version="2.0" />
			<p7:enum name="wired.event.file.set_permissions" value="15" version="2.0" />
			<p7:enum name="wired.event.file.set_label" value="16" version="2.0" />
			<p7:enum name="wired.event.file.deleted" value="17" version="2.0" />
			<p7:enum name="wired.event.file.created_directory" value="18" version="2.0" />
			<p7:enum name="wired.event.file.searched" value="19" version="2.0" />
			<p7:enum name="wired.event.file.previewed_file" value="20" version="2.0" />
			<p7:enum name="wired.event.account.changed_password" value="21" version="2.0" />
			<p7:enum name="wired.event.account.listed_users" value="22" version="2.0" />
			<p7:enum name="wired.event.account.listed_groups" value="23" version="2.0" />
			<p7:enum name="wired.event.account.read_user" value="24" version="2.0" />
			<p7:enum name="wired.event.account.read_group" value="25" version="2.0" />
			<p7:enum name="wired.event.account.created_user" value="26" version="2.0" />
			<p7:enum name="wired.event.account.created_group" value="27" version="2.0" />
			<p7:enum name="wired.event.account.edited_user" value="28" version="2.0" />
			<p7:enum name="wired.event.account.edited_group" value="29" version="2.0" />
			<p7:enum name="wired.event.account.deleted_user" value="30" version="2.0" />
			<p7:enum name="wired.event.account.deleted_group" value="31" version="2.0" />
			<p7:enum name="wired.event.message.sent" value="32" version="2.0" />
			<p7:enum name="wired.event.message.broadcasted" value="33" version="2.0" />
			<p7:enum name="wired.event.board.got_boards" value="34" version="2.0" />
			<p7:enum name="wired.event.board.got_threads" value="35" version="2.0" />
			<p7:enum name="wired.event.board.got_thread" value="36" version="2.0" />
			<p7:enum name="wired.event.board.added_board" value="37" version="2.0" />
			<p7:enum name="wired.event.board.renamed_board" value="38" version="2.0" />
			<p7:enum name="wired.event.board.moved_board" value="39" version="2.0" />
			<p7:enum name="wired.event.board.deleted_board" value="40" version="2.0" />
			<p7:enum name="wired.event.board.got_board_info" value="41" version="2.0" />
			<p7:enum name="wired.event.board.set_board_info" value="42" version="2.0" />
			<p7:enum name="wired.event.board.added_thread" value="43" version="2.0" />
			<p7:enum name="wired.event.board.edited_thread" value="44" version="2.0" />
			<p7:enum name="wired.event.board.moved_thread" value="45" version="2.0" />
			<p7:enum name="wired.event.board.deleted_thread" value="46" version="2.0" />
			<p7:enum name="wired.event.board.added_post" value="47" version="2.0" />
			<p7:enum name="wired.event.board.edited_post" value="48" version="2.0" />
			<p7:enum name="wired.event.board.deleted_post" value="49" version="2.0" />
			<p7:enum name="wired.event.transfer.started_file_download" value="50" version="2.0" />
			<p7:enum name="wired.event.transfer.stopped_file_download" value="51" version="2.0" />
			<p7:enum name="wired.event.transfer.completed_file_download" value="52" version="2.0" />
			<p7:enum name="wired.event.transfer.started_file_upload" value="53" version="2.0" />
			<p7:enum name="wired.event.transfer.stopped_file_upload" value="54" version="2.0" />
			<p7:enum name="wired.event.transfer.completed_file_upload" value="55" version="2.0" />
			<p7:enum name="wired.event.transfer.completed_directory_upload" value="56" version="2.0" />
			<p7:enum name="wired.event.log.got_log" value="57" version="2.0" />
			<p7:enum name="wired.event.events.got_events" value="58" version="2.0" />
			<p7:enum name="wired.event.settings.got_settings" value="59" version="2.0" />
			<p7:enum name="wired.event.settings.set_settings" value="60" version="2.0" />
			<p7:enum name="wired.event.banlist.got_bans" value="61" version="2.0" />
			<p7:enum name="wired.event.banlist.added_ban" value="62" version="2.0" />
			<p7:enum name="wired.event.banlist.deleted_ban" value="63" version="2.0" />
			<p7:enum name="wired.event.tracker.got_categories" value="64" version="2.0" />
			<p7:enum name="wired.event.tracker.got_servers" value="65" version="2.0" />
			<p7:enum name="wired.event.tracker.registered_server" value="66" version="2.0" />
		</p7:field>
		<p7:field name="wired.event.time" type="date" id="10008" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.event.parameters" type="list" listtype="string" id="10009" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.settings.register_with_trackers" type="bool" id="10010" version="2.0">
			<p7:documentation>
				Indicates whether the server should register with the trackers listed in
				[field:wired.setting.trackers].
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.settings.trackers" type="list" listtype="string" id="10011" version="2.0">
			<p7:documentation>
				URLs of trackers the server should register with if [field:wired.settings.register_with_trackers]
				is on. The URLs should be in the "wired://server[:port]/Category" format.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.banlist.ip" type="string" id="10012" version="2.0">
			<p7:documentation>
				An entry in the banlist. Should be set to the string representation of either an IPv4
				address, e.g. "127.0.0.1", or an IPv6 address, e.g. "::1". It can also be a netblock, such as
				"127.0.0.1/8", or a wildcard string, such as "127.0.0.*".
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.banlist.expiration_date" type="date" id="10013" version="2.0">
			<p7:documentation>
				Expiration date of an entry in the banlist.
			</p7:documentation>
		</p7:field>
		
		<p7:field name="wired.tracker.tracker" type="bool" id="11000" version="2.0">
			<p7:documentation>
				Indicates whether the server also functions as a tracker.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.tracker.categories" type="list" listtype="string" id="11001" version="2.0">
			<p7:documentation>
				List of configured tracker categories.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.tracker.category" type="string" id="11002" version="2.0">
			<p7:documentation>
				A single tracker category, similar to [field:wired.tracker.categories] but used when
				registering.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.tracker.ip" type="string" id="11003" version="2.0">
			<p7:documentation>
				IP address of a server when registering with a tracker.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.tracker.port" type="uint32" id="11004" version="2.0">
			<p7:documentation>
				Port of a server when registering with a tracker.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.tracker.url" type="string" id="11005" version="2.0">
			<p7:documentation>
				URL of a server registered with a tracker. The URL should be in the "wired://server[:port]/Category"
				format.
			</p7:documentation>
		</p7:field>
		<p7:field name="wired.tracker.users" type="uint32" id="11006" version="2.0">
			<p7:documentation>
				Number of users currently logged in to a server registered with a tracker.
			</p7:documentation>
		</p7:field>
	</p7:fields>
	
	<p7:collections>
		<p7:collection name="wired.info.host_info">
			<p7:member field="wired.info.application.name" />
			<p7:member field="wired.info.application.version" />
			<p7:member field="wired.info.application.build" />
			<p7:member field="wired.info.os.name" />
			<p7:member field="wired.info.os.version" />
			<p7:member field="wired.info.arch" />
			<p7:member field="wired.info.supports_rsrc" />
		</p7:collection>
		
		<p7:collection name="wired.info.server_info">
			<p7:member field="wired.info.name" />
			<p7:member field="wired.info.description" />
			<p7:member field="wired.info.banner" />
			<p7:member field="wired.info.downloads" />
			<p7:member field="wired.info.uploads" />
			<p7:member field="wired.info.download_speed" />
			<p7:member field="wired.info.upload_speed" />
		</p7:collection>

		<p7:collection name="wired.user.info">
			<p7:member field="wired.user.id" />
			<p7:member field="wired.user.idle" />
			<p7:member field="wired.user.nick" />
			<p7:member field="wired.user.status" />
			<p7:member field="wired.user.icon" />
		</p7:collection>
		
		<p7:collection name="wired.file.info">
			<p7:member field="wired.file.path" />
			<p7:member field="wired.file.type" />
			<p7:member field="wired.file.creation_time" />
			<p7:member field="wired.file.modification_time" />
			<p7:member field="wired.file.link" />
			<p7:member field="wired.file.executable" />
			<p7:member field="wired.file.label" />
			<p7:member field="wired.file.volume" />
		</p7:collection>
		
		<p7:collection name="wired.account.privileges">
			<p7:member field="wired.account.user.cannot_set_nick" />
			<p7:member field="wired.account.user.get_info" />
			<p7:member field="wired.account.user.disconnect_users" />
			<p7:member field="wired.account.user.ban_users" />
			<p7:member field="wired.account.user.cannot_be_disconnected" />
			<p7:member field="wired.account.user.get_users" />
			<p7:member field="wired.account.chat.kick_users" />
			<p7:member field="wired.account.chat.set_topic" />
			<p7:member field="wired.account.chat.create_chats" />
			<p7:member field="wired.account.message.send_messages" />
			<p7:member field="wired.account.message.broadcast" />
			<p7:member field="wired.account.board.read_boards" />
			<p7:member field="wired.account.board.add_boards" />
			<p7:member field="wired.account.board.move_boards" />
			<p7:member field="wired.account.board.rename_boards" />
			<p7:member field="wired.account.board.delete_boards" />
			<p7:member field="wired.account.board.set_board_info" />
			<p7:member field="wired.account.board.get_board_info" />
			<p7:member field="wired.account.board.add_threads" />
			<p7:member field="wired.account.board.move_threads" />
			<p7:member field="wired.account.board.add_posts" />
			<p7:member field="wired.account.board.edit_own_threads_and_posts" />
			<p7:member field="wired.account.board.edit_all_threads_and_posts" />
			<p7:member field="wired.account.board.delete_own_threads_and_posts" />
			<p7:member field="wired.account.board.delete_all_threads_and_posts" />
			<p7:member field="wired.account.file.list_files" />
			<p7:member field="wired.account.file.get_info" />
			<p7:member field="wired.account.file.create_directories" />
			<p7:member field="wired.account.file.create_links" />
			<p7:member field="wired.account.file.move_files" />
			<p7:member field="wired.account.file.rename_files" />
			<p7:member field="wired.account.file.set_type" />
			<p7:member field="wired.account.file.set_comment" />
			<p7:member field="wired.account.file.set_permissions" />
			<p7:member field="wired.account.file.set_executable" />
			<p7:member field="wired.account.file.delete_files" />
			<p7:member field="wired.account.file.access_all_dropboxes" />
			<p7:member field="wired.account.file.recursive_list_depth_limit" />
			<p7:member field="wired.account.transfer.download_files" />
			<p7:member field="wired.account.transfer.upload_files" />
			<p7:member field="wired.account.transfer.upload_directories" />
			<p7:member field="wired.account.transfer.upload_anywhere" />
			<p7:member field="wired.account.transfer.download_limit" />
			<p7:member field="wired.account.transfer.upload_limit" />
			<p7:member field="wired.account.transfer.download_speed_limit" />
			<p7:member field="wired.account.transfer.upload_speed_limit" />
			<p7:member field="wired.account.account.change_password" />
			<p7:member field="wired.account.account.list_accounts" />
			<p7:member field="wired.account.account.read_accounts" />
			<p7:member field="wired.account.account.create_users" />
			<p7:member field="wired.account.account.edit_users" />
			<p7:member field="wired.account.account.delete_users" />
			<p7:member field="wired.account.account.create_groups" />
			<p7:member field="wired.account.account.edit_groups" />
			<p7:member field="wired.account.account.delete_groups" />
			<p7:member field="wired.account.account.raise_account_privileges" />
			<p7:member field="wired.account.log.view_log" />
			<p7:member field="wired.account.events.view_events" />
			<p7:member field="wired.account.settings.get_settings" />
			<p7:member field="wired.account.settings.set_settings" />
			<p7:member field="wired.account.banlist.get_bans" />
			<p7:member field="wired.account.banlist.add_bans" />
			<p7:member field="wired.account.banlist.delete_bans" />
			<p7:member field="wired.account.tracker.list_servers" />
			<p7:member field="wired.account.tracker.register_servers" />
		</p7:collection>
	</p7:collections>

	<p7:messages>
		<p7:message name="wired.okay" id="1000" version="2.0">
			<p7:documentation>
				Acknowledgement message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.error" id="1001" version="2.0">
			<p7:documentation>
				Error message. [field:wired.error] contains the error returned. [field:wired.error.string]
				is optional, but should contain an additional error string if [field:wired.error] is
				[enum:wired.error.internal_error].
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.error" use="required" version="2.0" />
			<p7:parameter field="wired.error.string" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.client_info" id="2000" version="2.0">
			<p7:documentation>
				Client info message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.info.host_info" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.server_info" id="2001" version="2.0">
			<p7:documentation>
				Server info message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.info.host_info" use="required" version="2.0" />
			<p7:parameter collection="wired.info.server_info" use="required" version="2.0" />
			<p7:parameter field="wired.info.start_time" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.count" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.size" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.send_ping" id="2002" version="2.0">
			<p7:documentation>
				Ping message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.ping" id="2003" version="2.0">
			<p7:documentation>
				Ping reply.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.send_login" id="2004" version="2.0">
			<p7:documentation>
				Login message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.login" use="required" version="2.0" />
			<p7:parameter field="wired.user.password" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.login" id="2005" version="2.0">
			<p7:documentation>
				Login reply.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.banned" id="2006" version="2.0">
			<p7:documentation>
				Login error due to ban. [field:wired.banlist.expiration_date] indicates the expiration date
				of the ban, if applicable.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.banlist.expiration_date" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.user.set_nick" id="3000" version="2.0">
			<p7:documentation>
				Change nick message. [field:wired.user.nick] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.set_status" id="3001" version="2.0">
			<p7:documentation>
				Change status message. [field:wired.user.status] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.status" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.set_icon" id="3002" version="2.0">
			<p7:documentation>
				Change icon message. [field:wired.user.icon] may be empty.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.icon" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.set_idle" id="3003" version="2.0">
			<p7:documentation>
				Change idle flag message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.idle" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.get_info" id="3004" version="2.0">
			<p7:documentation>
				Get info message for a user.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.info" id="3005" version="2.0">
			<p7:documentation>
				User info reply for a user. [field:wired.user.cipher.name] and [field:wired.user.cipher.bits]
				should be set only if the user has connected using encryption.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.user.info" use="required" version="2.0" />
			<p7:parameter field="wired.user.login" use="required" version="2.0" />
			<p7:parameter field="wired.user.ip" use="required" version="2.0" />
			<p7:parameter field="wired.user.host" use="required" version="2.0" />
			<p7:parameter field="wired.user.cipher.name" version="2.0" />
			<p7:parameter field="wired.user.cipher.bits" version="2.0" />
			<p7:parameter field="wired.user.login_time" use="required" version="2.0" />
			<p7:parameter field="wired.user.idle_time" use="required" version="2.0" />
			<p7:parameter collection="wired.info.host_info" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.disconnect_user" id="3006" version="2.0">
			<p7:documentation>
				Disconnect user. [field:wired.user.disconnect_message] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnect_message" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.ban_user" id="3007" version="2.0">
			<p7:documentation>
				Ban user message. This is equivalent to adding the user to the banlist and then
				disconnecting the user. [field:wired.user.disconnect_message] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnect_message" use="required" version="2.0" />
			<p7:parameter field="wired.banlist.expiration_date" version="2.0" />
		</p7:message>

		<p7:message name="wired.user.get_users" id="3008" version="2.0">
			<p7:documentation>
				Get user list message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.user.user_list" id="3009" version="2.0">
			<p7:documentation>
				User list item message. If [field:wired.user.state] is [enum:wired.user.state.transferring],
				the fields [field:wired.transfer.type], [field:wired.file.path], [field:wired.file.size],
				[field:wired.transfer.transferred], [field:wired.transfer.speed] and [field:wired.transfer.queue_position]
				should be set. If [field:wired.transfer.queue_position] is set and not equal to 0, the
				transfer is currently in the queue at that position. Otherwise, the transfer is ongoing,
				and [field:wired.transfer.transferred] and [field:wired.transfer.speed] indicate its
				progression.
				
				rsrc TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.user.info" use="required" version="2.0" />
			<p7:parameter field="wired.user.idle_time" use="required" version="2.0" />
			<p7:parameter field="wired.user.state" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
			<p7:parameter field="wired.transfer.type" version="2.0" />
			<p7:parameter field="wired.file.path" version="2.0" />
			<p7:parameter field="wired.transfer.data_size" version="2.0" />
			<p7:parameter field="wired.transfer.rsrc_size" version="2.0" />
			<p7:parameter field="wired.transfer.transferred" version="2.0" />
			<p7:parameter field="wired.transfer.speed" version="2.0" />
			<p7:parameter field="wired.transfer.queue_position" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.user.user_list.done" id="3010" version="2.0">
			<p7:documentation>
				User list completion message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.join_chat" id="4000" version="2.0">
			<p7:documentation>
				Join chat message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.leave_chat" id="4001" version="2.0">
			<p7:documentation>
				Leave chat message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_list" id="4002" version="2.0">
			<p7:documentation>
				User list item message for a chat.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter collection="wired.user.info" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_list.done" id="4003" version="2.0">
			<p7:documentation>
				User list completion message for a chat.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_join" id="4004" version="2.0">
			<p7:documentation>
				User join message for a chat.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter collection="wired.user.info" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_leave" id="4005" version="2.0">
			<p7:documentation>
				User leave message for a chat.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_status" id="4006" version="2.0">
			<p7:documentation>
				User status message for a chat. Any of the fields, except [field:wired.user.id] may have
				changed, and it is not possible to find out which, except by caching the previous values.
				[field:wired.user.status] may be the empty string, but [field:wired.user.nick] may not.
				
				wired.account.color TBD
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.idle" use="required" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
			<p7:parameter field="wired.user.status" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_icon" id="4007" version="2.0">
			<p7:documentation>
				User icon message for a chat. [field:wired.user.icon] may be empty.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.icon" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_disconnect" id="4008" version="2.0">
			<p7:documentation>
				User disconnected message for a chat. [field:wired.user.disconnected_id] is the user who was
				disconnected. It is not possible to discover who disconnected the user since that user may
				not be present on each chat. [field:wired.user.disconnect_message] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnected_id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnect_message" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.chat.kick_user" id="4009" version="2.0">
			<p7:documentation>
				Kick user message for a chat. Kicking the user from the public chat is not equal to
				disconnecting the user, and the user can rejoin the chat or send other messages.
				[field:wired.user.disconnect_message] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnect_message" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_kick" id="4010" version="2.0">
			<p7:documentation>
				User kicked message for a chat. [wired.user.id] is the user who performed the kick, and
				[field:wired.user.disconnected_id] is the user who was kicked. [field:wired.user.disconnect_message]
				may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnected_id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnect_message" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_ban" id="4011" version="2.0">
			<p7:documentation>
				User banned message for a chat. [field:wired.user.disconnected_id] is the user who was
				banned. It is not possible to discover who disconnected the user since that user may
				not be present on each chat. [field:wired.user.disconnect_message] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnected_id" use="required" version="2.0" />
			<p7:parameter field="wired.user.disconnect_message" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.chat.set_topic" id="4012" version="2.0">
			<p7:documentation>
				Change topic for a chat. [field:wired.chat.topic.topic] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.topic.topic" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.topic" id="4013" version="2.0">
			<p7:documentation>
				Topic message for a chat. [field:wired.chat.topic.topic] may be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
			<p7:parameter field="wired.chat.topic.topic" use="required" version="2.0" />
			<p7:parameter field="wired.chat.topic.time" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.send_say" id="4014" version="2.0">
			<p7:documentation>
				Send a normal chat message for a chat. [field:wired.chat.say] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.say" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.say" id="4015" version="2.0">
			<p7:documentation>
				Normal chat message for a chat. [field:wired.chat.say] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.say" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.send_me" id="4016" version="2.0">
			<p7:documentation>
				Send an action chat message for a chat. [field:wired.chat.me] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.me" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.me" id="4017" version="2.0">
			<p7:documentation>
				Action chat message for a chat. [field:wired.chat.me] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.me" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.create_chat" id="4018" version="2.0">
			<p7:documentation>
				Create new chat message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.chat_created" id="4019" version="2.0">
			<p7:documentation>
				Create new chat reply.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.invite_user" id="4020" version="2.0">
			<p7:documentation>
				Invitation message for a user for a chat.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.invitation" id="4021" version="2.0">
			<p7:documentation>
				Invivation message from a user for a chat.
			</p7:documentation>
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.decline_invitation" id="4022" version="2.0">
			<p7:documentation>
				Decline invitation from a user for a chat.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.chat.user_decline_invitation" id="4023" version="2.0">
			<p7:documentation>
				Declination for an invitation from a user for a chat.
			</p7:documentation>
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.chat.id" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.message.send_message" id="5000" version="2.0">
			<p7:documentation>
				Send private message to a user. [field:wired.message.message] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.message.message" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.message.message" id="5001" version="2.0">
			<p7:documentation>
				Private message from a user. [field:wired.message.message] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.message.message" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.message.send_broadcast" id="5002" version="2.0">
			<p7:documentation>
				Send broadcast message to all users. [field:wired.message.message] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.message.broadcast" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.message.broadcast" id="5003" version="2.0">
			<p7:documentation>
				Broadcast message to all users. [field:wired.message.message] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.user.id" use="required" version="2.0" />
			<p7:parameter field="wired.message.broadcast" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.get_boards" id="6000" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.board_list" id="6001" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.readable" use="required" version="2.0" />
			<p7:parameter field="wired.board.writable" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.board_list.done" id="6002" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.get_threads" id="6003" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.thread_list" id="6004" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.post_date" use="required" version="2.0" />
			<p7:parameter field="wired.board.edit_date" version="2.0" />
			<p7:parameter field="wired.board.own_thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.replies" use="required" version="2.0" />
			<p7:parameter field="wired.board.latest_reply" version="2.0" />
			<p7:parameter field="wired.board.latest_reply_date" version="2.0" />
			<p7:parameter field="wired.board.subject" use="required" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.thread_list.done" id="6005" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.get_thread" id="6006" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.thread" id="6007" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.text" use="required" version="2.0" />
			<p7:parameter field="wired.user.icon" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.post_list" id="6008" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.post" use="required" version="2.0" />
			<p7:parameter field="wired.board.post_date" use="required" version="2.0" />
			<p7:parameter field="wired.board.edit_date" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
			<p7:parameter field="wired.user.icon" use="required" version="2.0" />
			<p7:parameter field="wired.board.own_post" use="required" version="2.0" />
			<p7:parameter field="wired.board.text" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.post_list.done" id="6009" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.add_board" id="6010" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner.write" use="required" version="2.0" />
			<p7:parameter field="wired.board.group" use="required" version="2.0" />
			<p7:parameter field="wired.board.group.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.group.write" use="required" version="2.0" />
			<p7:parameter field="wired.board.everyone.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.everyone.write" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.board_added" id="6011" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.readable" use="required" version="2.0" />
			<p7:parameter field="wired.board.writable" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.rename_board" id="6012" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.new_board" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.board_renamed" id="6013" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.new_board" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.move_board" id="6014" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.new_board" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.board_moved" id="6015" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.new_board" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.delete_board" id="6016" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.board_deleted" id="6017" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.get_board_info" id="6018" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.board_info" id="6019" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner.write" use="required" version="2.0" />
			<p7:parameter field="wired.board.group" use="required" version="2.0" />
			<p7:parameter field="wired.board.group.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.group.write" use="required" version="2.0" />
			<p7:parameter field="wired.board.everyone.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.everyone.write" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.set_board_info" id="6020" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.owner.write" use="required" version="2.0" />
			<p7:parameter field="wired.board.group" use="required" version="2.0" />
			<p7:parameter field="wired.board.group.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.group.write" use="required" version="2.0" />
			<p7:parameter field="wired.board.everyone.read" use="required" version="2.0" />
			<p7:parameter field="wired.board.everyone.write" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.board_info_changed" id="6021" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.readable" use="required" version="2.0" />
			<p7:parameter field="wired.board.writable" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.add_thread" id="6022" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.subject" use="required" version="2.0" />
			<p7:parameter field="wired.board.text" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.thread_added" id="6023" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.board" use="required" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.post_date" use="required" version="2.0" />
			<p7:parameter field="wired.board.edit_date" version="2.0" />
			<p7:parameter field="wired.board.own_thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.subject" use="required" version="2.0" />
			<p7:parameter field="wired.board.replies" use="required" version="2.0" />
			<p7:parameter field="wired.board.latest_reply" version="2.0" />
			<p7:parameter field="wired.board.latest_reply_date" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
			<p7:parameter field="wired.user.icon" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.edit_thread" id="6024" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.subject" use="required" version="2.0" />
			<p7:parameter field="wired.board.text" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.board.thread_changed" id="6025" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.subject" use="required" version="2.0" />
			<p7:parameter field="wired.board.edit_date" version="2.0" />
			<p7:parameter field="wired.board.replies" use="required" version="2.0" />
			<p7:parameter field="wired.board.latest_reply_date" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.move_thread" id="6026" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.new_board" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.thread_moved" id="6027" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.new_board" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.delete_thread" id="6028" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.thread_deleted" id="6029" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.add_post" id="6030" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.thread" use="required" version="2.0" />
			<p7:parameter field="wired.board.subject" use="required" version="2.0" />
			<p7:parameter field="wired.board.text" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.edit_post" id="6031" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.post" use="required" version="2.0" />
			<p7:parameter field="wired.board.subject" use="required" version="2.0" />
			<p7:parameter field="wired.board.text" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.delete_post" id="6032" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.board.post" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.subscribe_boards" id="6033" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.board.unsubscribe_boards" id="6034" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.list_directory" id="7000" version="2.0">
			<p7:documentation>
				List a directory. [field:wired.file.path] may not be the empty string. If
				[field:wired.file.recursive] is set, replies should include the full directory tree.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.recursive" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.file_list" id="7001" version="2.0">
			<p7:documentation>
				File list item for a directory. [field:wired.file.path] may not be the empty string.

				If [field:wired.file.type] is [enum:wired.file.type.dropbox], [field:wired.file.readable]
				and [field:wired.file.writable] should be set.
				
				rsrc TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.file.info" use="required" version="2.0" />
			<p7:parameter field="wired.file.data_size" version="2.0" />
			<p7:parameter field="wired.file.rsrc_size" version="2.0" />
			<p7:parameter field="wired.file.directory_count" version="2.0" />
			<p7:parameter field="wired.file.readable" version="2.0" />
			<p7:parameter field="wired.file.writable" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.file_list.done" id="7002" version="2.0">
			<p7:documentation>
				File list completion message.
				
				If [field:wired.file.type] is [enum:wired.file.type.dropbox], [field:wired.file.readable]
				and [field:wired.file.writable] should be set.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.available" use="required" version="2.0" />
			<p7:parameter field="wired.file.readable" version="2.0" />
			<p7:parameter field="wired.file.writable" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.get_info" id="7003" version="2.0">
			<p7:documentation>
				Get info message for a file. [field:wired.file.path] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.info" id="7004" version="2.0">
			<p7:documentation>
				Info message for a file or a directory. [field:wired.file.path] may not be the empty string,
				but [field:wired.file.comment] may be.
				
				If [field:wired.file.type] is [enum:wired.file.type.dropbox], [field:wired.file.owner],
				[field:wired.file.owner.read], [field:wired.file.owner.write], [field:wired.file.group],
				[field:wired.file.group.read], [field:wired.file.group.read], [field:wired.file.everyone.read],
				[field:wired.file.everyone.write], [field:wired.file.readable] and [field:wired.file.writable]
				should be set.
				
				rsrc TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.file.info" use="required" version="2.0" />
			<p7:parameter field="wired.file.data_size" version="2.0" />
			<p7:parameter field="wired.file.rsrc_size" version="2.0" />
			<p7:parameter field="wired.file.directory_count" version="2.0" />
			<p7:parameter field="wired.file.comment" use="required" version="2.0" />
			<p7:parameter field="wired.file.owner" version="2.0" />
			<p7:parameter field="wired.file.owner.read" version="2.0" />
			<p7:parameter field="wired.file.owner.write" version="2.0" />
			<p7:parameter field="wired.file.group" version="2.0" />
			<p7:parameter field="wired.file.group.read" version="2.0" />
			<p7:parameter field="wired.file.group.write" version="2.0" />
			<p7:parameter field="wired.file.everyone.read" version="2.0" />
			<p7:parameter field="wired.file.everyone.write" version="2.0" />
			<p7:parameter field="wired.file.readable" version="2.0" />
			<p7:parameter field="wired.file.writable" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.move" id="7005" version="2.0">
			<p7:documentation>
				Move file or directory message. [field:wired.file.path] and [field:wired.file.new_path] may not
				be the empty string, and may not be equal.
				
				[field:wired.file.new_path] should be the full destination path, not just the destination
				directory.
				
				If the server can\'t move the file, it may perform a copy followed by a delete instead.
				[field:wired.file.volume] can be used to see if this will be the case.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.new_path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.link" id="7006" version="2.0">
			<p7:documentation>
				Link file or directory message.  [field:wired.file.path] and [field:wired.file.new_path] may not
				be the empty string, and may not be equal.
				
				[field:wired.file.new_path] should be the full destination path, not just the destination
				directory.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.new_path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.delete" id="7007" version="2.0">
			<p7:documentation>
				Delete file or directory message. [field:wired.file.path] may not be the empty string.
				
				If it\'s a directory, the servern should perform a recursive delete of the full directory
				tree.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.set_type" id="7008" version="2.0">
			<p7:documentation>
				Change directory type message. [field:wired.file.path] may not be the empty string.
				
				[field:wired.file.type] may not be [enum:wired.file.type.file].
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.type" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.set_comment" id="7009" version="2.0">
			<p7:documentation>
				Change directory type message. [field:wired.file.path] may not be the empty string,
				but [field:wired.file.comment] may be.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.comment" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.set_executable" id="7010" version="2.0">
			<p7:documentation>
				Change executable flag message for a file. [field:wired.file.path] may not be the
				empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.executable" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.file.set_permissions" id="7011" version="2.0">
			<p7:documentation>
				Change executable flag message for a drop box directory. [field:wired.file.path] may not
				be the empty string, but [field:wired.file.owner] and [field:wired.file.group] may be.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.owner" use="required" version="2.0" />
			<p7:parameter field="wired.file.owner.read" use="required" version="2.0" />
			<p7:parameter field="wired.file.owner.write" use="required" version="2.0" />
			<p7:parameter field="wired.file.group" use="required" version="2.0" />
			<p7:parameter field="wired.file.group.read" use="required" version="2.0" />
			<p7:parameter field="wired.file.group.write" use="required" version="2.0" />
			<p7:parameter field="wired.file.everyone.read" use="required" version="2.0" />
			<p7:parameter field="wired.file.everyone.write" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.set_label" id="7012" version="2.0">
			<p7:documentation>
				Change label for a file or directory. [field:wired.file.path] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.label" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.file.create_directory" id="7013" version="2.0">
			<p7:documentation>
				Create a new directory message. [field:wired.file.path] may not be the empty string, but
				[field:wired.file.owner] and [field:wired.file.group] may be.
				
				[field:wired.file.path] should be the full destination path.
				
				If [field:wired.file.type] is set, this should be the directory type, otherwise it
				should be [enum:wired.file.type.directory].
				
				If [field:wired.file.type] is [enum:wired.file.type.dropbox], [field:wired.file.owner],
				[field:wired.file.owner.read], [field:wired.file.owner.write], [field:wired.file.group],
				[field:wired.file.group.read], [field:wired.file.group.write], [field:wired.file.everyone.read]
				and [field:wired.file.everyone.write] should be set.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.type" version="2.0" />
			<p7:parameter field="wired.file.owner" version="2.0" />
			<p7:parameter field="wired.file.owner.read" version="2.0" />
			<p7:parameter field="wired.file.owner.write" version="2.0" />
			<p7:parameter field="wired.file.group" version="2.0" />
			<p7:parameter field="wired.file.group.read" version="2.0" />
			<p7:parameter field="wired.file.group.write" version="2.0" />
			<p7:parameter field="wired.file.everyone.read" version="2.0" />
			<p7:parameter field="wired.file.everyone.write" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.search" id="7014" version="2.0">
			<p7:documentation>
				Search files message. [field:wired.file.query] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.query" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.search_list" id="7015" version="2.0">
			<p7:documentation>
				Search list item message. This message should behave exactly like [message:wired.file.file_list].
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.file.info" use="required" version="2.0" />
			<p7:parameter field="wired.file.data_size" version="2.0" />
			<p7:parameter field="wired.file.rsrc_size" version="2.0" />
			<p7:parameter field="wired.file.directory_count" version="2.0" />
			<p7:parameter field="wired.file.readable" version="2.0" />
			<p7:parameter field="wired.file.writable" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.search_list.done" id="7016" version="2.0">
			<p7:documentation>
				Search list completion message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.preview_file" id="7017" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.preview" id="7018" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.file.preview" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.subscribe_directory" id="7019" version="2.0">
			<p7:documentation>
				Subscribe to a directory message. [field:wired.file.path] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.unsubscribe_directory" id="7020" version="2.0">
			<p7:documentation>
				Subscribe to a directory message. [field:wired.file.path] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.directory_changed" id="7021" version="2.0">
			<p7:documentation>
				Directory changed message. [field:wired.file.path] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.file.directory_deleted" id="7022" version="2.0">
			<p7:documentation>
				Directory deleted message. [field:wired.file.path] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.privileges" id="8000" version="2.0">
			<p7:documentation>
				Account privileges message. [field:wired.account.name] may not be the empty string,
				but [field:wired.account.group] may be. [field:wired.account.groups] may be the
				empty list.
				
				This can be used to validate a client interface.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.group" use="required" version="2.0" />
			<p7:parameter field="wired.account.groups" use="required" version="2.0" />
			<p7:parameter collection="wired.account.privileges" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.change_password" id="8001" version="2.0">
			<p7:documentation>
				Change password message. [field:wired.account.password] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.password" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.list_users" id="8002" version="2.0">
			<p7:documentation>
				List user accounts message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.user_list" id="8003" version="2.0">
			<p7:documentation>
				User accounts list item message. [field:wired.account.name], [field:wired.account.password]
				and [field:wired.account.edited_by] may not be the empty string.
				
				If the user account shall not belong to a primary group, [field:wired.account.group] may be the
				empty string, otherwise it must be a valid group name. Likewise, if the user account shall not
				belong to any secondary groups, [field:wired.account.groups] may be the empty list, otherwise it
				must contain valid group names.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.full_name" use="required" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.creation_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.modification_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.login_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.edited_by" use="required" version="2.0" />
			<p7:parameter field="wired.account.downloads" use="required" version="2.0" />
			<p7:parameter field="wired.account.download_transferred" use="required" version="2.0" />
			<p7:parameter field="wired.account.uploads" use="required" version="2.0" />
			<p7:parameter field="wired.account.upload_transferred" use="required" version="2.0" />
			<p7:parameter field="wired.account.group" use="required" version="2.0" />
			<p7:parameter field="wired.account.groups" use="required" version="2.0" />
			<p7:parameter field="wired.account.password" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.user_list.done" id="8004" version="2.0">
			<p7:documentation>
				User accounts list completion message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.list_groups" id="8005" version="2.0">
			<p7:documentation>
				List group accounts message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.group_list" id="8006" version="2.0">
			<p7:documentation>
				User accounts list item message. [field:wired.account.name] and
				[field:wired.account.edited_by] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.creation_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.modification_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.edited_by" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.group_list.done" id="8007" version="2.0">
			<p7:documentation>
				Group accounts list completion message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.read_user" id="8008" version="2.0">
			<p7:documentation>
				Read user account message. [field:wired.account.name] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.user" id="8009" version="2.0">
			<p7:documentation>
				User account message. [field:wired.account.name], [field:wired.account.edited_by]
				and [field:wired.account.password] may not be the empty string, but
				[field:wired.account.full_name] may be.
				
				If the user account shall not belong to a primary group, [field:wired.account.group] may be the
				empty string, otherwise it must be a valid group name. Likewise, if the user account shall not
				belong to any secondary groups, [field:wired.account.groups] may be the empty list, otherwise it
				must contain valid group names.
				
				If it is set, [field:wired.account.files] may be the empty string, otherwise it must
				be a valid path within the files directory.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.full_name" use="required" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.creation_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.modification_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.login_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.edited_by" use="required" version="2.0" />
			<p7:parameter field="wired.account.downloads" use="required" version="2.0" />
			<p7:parameter field="wired.account.download_transferred" use="required" version="2.0" />
			<p7:parameter field="wired.account.uploads" use="required" version="2.0" />
			<p7:parameter field="wired.account.upload_transferred" use="required" version="2.0" />
			<p7:parameter field="wired.account.group" use="required" version="2.0" />
			<p7:parameter field="wired.account.groups" use="required" version="2.0" />
			<p7:parameter field="wired.account.password" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
			<p7:parameter field="wired.account.files" version="2.0" />
			<p7:parameter collection="wired.account.privileges" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.read_group" id="8010" version="2.0">
			<p7:documentation>
				Read group account message. [field:wired.account.name] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.group" id="8011" version="2.0">
			<p7:documentation>
				User account message. [field:wired.account.name] and [field:wired.account.edited_by]
				may not be the empty string.
				
				If it is set, [field:wired.account.files] may be the empty string, otherwise it must
				be a valid path within the files directory.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.creation_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.modification_time" use="required" version="2.0" />
			<p7:parameter field="wired.account.edited_by" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
			<p7:parameter field="wired.account.files" version="2.0" />
			<p7:parameter collection="wired.account.privileges" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.create_user" id="8012" version="2.0">
			<p7:documentation>
				Create user account message. [field:wired.account.name], [field:wired.account.password] may
				not be the empty string, but [field:wired.account.full_name] may be.
				
				If the user account shall not belong to a primary group, [field:wired.account.group] may be the
				empty string, otherwise it must be a valid group name. Likewise, if the user account shall not
				belong to any secondary groups, [field:wired.account.groups] may be the empty list, otherwise it
				must contain valid group names.
				
				If it is set, [field:wired.account.files] may be the empty string, otherwise it must
				be a valid path within the files directory.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.full_name" use="required" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.group" use="required" version="2.0" />
			<p7:parameter field="wired.account.groups" use="required" version="2.0" />
			<p7:parameter field="wired.account.password" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
			<p7:parameter field="wired.account.files" version="2.0" />
			<p7:parameter collection="wired.account.privileges" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.create_group" id="8013" version="2.0">
			<p7:documentation>
				Create group account message. [field:wired.account.name] may not be the empty string.
				
				If it is set, [field:wired.account.files] may be the empty string, otherwise it must
				be a valid path within the files directory.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
			<p7:parameter field="wired.account.files" version="2.0" />
			<p7:parameter collection="wired.account.privileges" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.edit_user" id="8014" version="2.0">
			<p7:documentation>
				Create user account message. [field:wired.account.name], [field:wired.account.password] may
				not be the empty string, but [field:wired.account.full_name] may be. If
				[field:wired.account.new_name] is set, it may not be the empty string, and the account
				should be renamed.
				
				If the user account shall not belong to a primary group, [field:wired.account.group] may be the
				empty string, otherwise it must be a valid group name. Likewise, if the user account shall not
				belong to any secondary groups, [field:wired.account.groups] may be the empty list, otherwise it
				must contain valid group names.
				
				If it is set, [field:wired.account.files] may be the empty string, otherwise it must
				be a valid path within the files directory.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.new_name" version="2.0" />
			<p7:parameter field="wired.account.full_name" use="required" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.group" use="required" version="2.0" />
			<p7:parameter field="wired.account.groups" use="required" version="2.0" />
			<p7:parameter field="wired.account.password" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
			<p7:parameter field="wired.account.files" version="2.0" />
			<p7:parameter collection="wired.account.privileges" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.edit_group" id="8015" version="2.0">
			<p7:documentation>
				Create group account message. [field:wired.account.name] may not be the empty string. If
				[field:wired.account.new_name] is set, it may not be the empty string, and the account
				should be renamed.
				
				If it is set, [field:wired.account.files] may be the empty string, otherwise it must
				be a valid path within the files directory.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.new_name" version="2.0" />
			<p7:parameter field="wired.account.comment" use="required" version="2.0" />
			<p7:parameter field="wired.account.color" version="2.0" />
			<p7:parameter field="wired.account.files" version="2.0" />
			<p7:parameter collection="wired.account.privileges" version="2.0" />
		</p7:message>

		<p7:message name="wired.account.delete_user" id="8016" version="2.0">
			<p7:documentation>
				Delete user account message. [field:wired.account.name] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
			<p7:parameter field="wired.account.disconnect_users" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.delete_group" id="8017" version="2.0">
			<p7:documentation>
				Delete group account message. [field:wired.account.name] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.account.name" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.subscribe_accounts" id="8018" version="2.0">
			<p7:documentation>
				Subscribe to changes in the account list.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.unsubscribe_accounts" id="8019" version="2.0">
			<p7:documentation>
				Unsubscribe from changes in the account list.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.account.accounts_changed" id="8020" version="2.0">
			<p7:documentation>
				Accounts list changed message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.transfer.download_file" id="9000" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.data_offset" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.rsrc_offset" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.transfer.upload_file" id="9001" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.data_size" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.rsrc_size" use="required" version="2.0" />
			<p7:parameter field="wired.file.executable" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.transfer.upload_directory" id="9002" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.transfer.queue" id="9003" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.queue_position" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.transfer.download" id="9004" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.data" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.rsrc" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.finderinfo" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.transfer.upload_ready" id="9005" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.data_offset" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.rsrc_offset" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.transfer.upload" id="9006" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.file.path" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.data" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.rsrc" use="required" version="2.0" />
			<p7:parameter field="wired.transfer.finderinfo" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.log.get_log" id="10000" version="2.0">
			<p7:documentation>
				Get log message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.log.list" id="10001" version="2.0">
			<p7:documentation>
				Log list item message. [field:wired.log.message] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.log.time" use="required" version="2.0" />
			<p7:parameter field="wired.log.level" use="required" version="2.0" />
			<p7:parameter field="wired.log.message" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.log.list.done" id="10002" version="2.0">
			<p7:documentation>
				Log list completion message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.log.subscribe" id="10003" version="2.0">
			<p7:documentation>
				Subscribe to log message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.log.unsubscribe" id="10004" version="2.0">
			<p7:documentation>
				Unsubscribe from log message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.log.message" id="10005" version="2.0">
			<p7:documentation>
				Log message. [field:wired.log.message] may not be the empty string.
			</p7:documentation>
			<p7:parameter field="wired.log.time" use="required" version="2.0" />
			<p7:parameter field="wired.log.level" use="required" version="2.0" />
			<p7:parameter field="wired.log.message" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.get_first_time" id="10006" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.first_time" id="10007" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.event.first_time" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.get_events" id="10008" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.event.from_time" version="2.0" />
			<p7:parameter field="wired.event.number_of_days" version="2.0" />
			<p7:parameter field="wired.event.last_event_count" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.event_list" id="10009" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.event.event" use="required" version="2.0" />
			<p7:parameter field="wired.event.time" use="required" version="2.0" />
			<p7:parameter field="wired.event.parameters" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
			<p7:parameter field="wired.user.login" use="required" version="2.0" />
			<p7:parameter field="wired.user.ip" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.event_list.done" id="10010" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.delete_events" id="10022" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.event.from_time" version="2.0" />
			<p7:parameter field="wired.event.to_time" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.subscribe" id="10011" version="2.0">
			<p7:documentation>
				Subscribe to events message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.unsubscribe" id="10012" version="2.0">
			<p7:documentation>
				Unsubscribe from events message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.event.event" id="10013" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:parameter field="wired.event.event" use="required" version="2.0" />
			<p7:parameter field="wired.event.time" use="required" version="2.0" />
			<p7:parameter field="wired.event.parameters" version="2.0" />
			<p7:parameter field="wired.user.nick" use="required" version="2.0" />
			<p7:parameter field="wired.user.login" use="required" version="2.0" />
			<p7:parameter field="wired.user.ip" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.settings.get_settings" id="10014" version="2.0">
			<p7:documentation>
				Get settings message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.settings.settings" id="10015" version="2.0">
			<p7:documentation>
				Settings message. [field:wired.info.name] may not be the empty string, but
				[field:wired.info.description] may be.
				
				If [field:wired.settings.register_with_trackers] is set, [field:wired.settings.trackers]
				may not be the empty list. Otherwise, it may.
				
				[field:wired.tracker.categories] may be the empty list.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.info.server_info" use="required" version="2.0" />
			<p7:parameter field="wired.settings.register_with_trackers" use="required" version="2.0" />
			<p7:parameter field="wired.settings.trackers" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.tracker" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.categories" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.settings.set_settings" id="10016" version="2.0">
			<p7:documentation>
				Settings message. [field:wired.info.name] may not be the empty string, but
				[field:wired.info.description] may be.
				
				If [field:wired.settings.register_with_trackers] is set, [field:wired.settings.trackers]
				may not be the empty list. Otherwise, it may.
				
				[field:wired.tracker.categories] may be the empty list.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter collection="wired.info.server_info" use="required" version="2.0" />
			<p7:parameter field="wired.settings.register_with_trackers" use="required" version="2.0" />
			<p7:parameter field="wired.settings.trackers" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.tracker" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.categories" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.banlist.get_bans" id="10017" version="2.0">
			<p7:documentation>
				Get bans message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.banlist.list" id="10018" version="2.0">
			<p7:documentation>
				Ban list item message. [field:wired.banlist.ip] may not be the empty string. If
				[field:wired.banlist.expiration_date] is not set, the ban does not expire.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.banlist.ip" use="required" version="2.0" />
			<p7:parameter field="wired.banlist.expiration_date" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.banlist.list.done" id="10019" version="2.0">
			<p7:documentation>
				Ban list completion message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.banlist.add_ban" id="10020" version="2.0">
			<p7:documentation>
				Add ban message. [field:wired.banlist.ip] may not be the empty string. If
				[field:wired.banlist.expiration_date] is not set, the ban does not expire.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.banlist.ip" use="required" version="2.0" />
			<p7:parameter field="wired.banlist.expiration_date" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.banlist.delete_ban" id="10021" version="2.0">
			<p7:documentation>
				Delete ban message. [field:wired.banlist.ip] may not be the empty string. This should
				match and delete exactly one ban. [field:wired.banlist.expiration_date] should be filled in
				to delete a temporary ban.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.banlist.ip" use="required" version="2.0" />
			<p7:parameter field="wired.banlist.expiration_date" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.tracker.get_categories" id="11000" version="2.0">
			<p7:documentation>
				Get tracker categories message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.tracker.categories" id="11001" version="2.0">
			<p7:documentation>
				Tracker categories message. [field:wired.tracker.categories] may be the empty list.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.tracker.categories" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.tracker.get_servers" id="11002" version="2.0">
			<p7:documentation>
				Get tracker servers message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.tracker.server_list" id="11003" version="2.0">
			<p7:documentation>
				Tracker servers list item message. [field:wired.info.name] may not be the empty string,
				but [field:wired.info.description], [field:wired.tracker.category] and
				[field:wired.tracker.url] may be.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.tracker.category" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.tracker" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.url" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.users" use="required" version="2.0" />
			<p7:parameter field="wired.info.name" use="required" version="2.0" />
			<p7:parameter field="wired.info.description" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.count" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.size" use="required" version="2.0" />
		</p7:message>
		
		<p7:message name="wired.tracker.server_list.done" id="11004" version="2.0">
			<p7:documentation>
				Tracker servers list completion message.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
		</p7:message>

		<p7:message name="wired.tracker.send_register" id="11005" version="2.0">
			<p7:documentation>
				Register server with tracker message. [field:wired.info.name] may not be the empty string,
				but [field:wired.info.description] and [field:wired.tracker.category] may be.
				
				If [field:wired.tracker.ip] is not set, the tracker should register the server using the
				originating address. [field:wired.tracker.port], however, must be set to the server\'s
				listening port.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.tracker.tracker" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.category" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.ip" version="2.0" />
			<p7:parameter field="wired.tracker.port" use="required" version="2.0" />
			<p7:parameter field="wired.tracker.users" use="required" version="2.0" />
			<p7:parameter field="wired.info.name" use="required" version="2.0" />
			<p7:parameter field="wired.info.description" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.count" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.size" use="required" version="2.0" />
		</p7:message>

		<p7:message name="wired.tracker.send_update" id="11007" version="2.0">
			<p7:documentation>
				Update server on tracker message.
				
				This message is intended to be used for periodic updates.
			</p7:documentation>
			<p7:parameter field="wired.transaction" version="2.0" />
			<p7:parameter field="wired.tracker.users" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.count" use="required" version="2.0" />
			<p7:parameter field="wired.info.files.size" use="required" version="2.0" />
		</p7:message>
        
	</p7:messages>

	<p7:transactions>
		<p7:transaction message="wired.client_info" originator="client" use="required" version="2.0">
			<p7:documentation>
				Should be the first transaction. Until this has been completed, all other messages
				should reply with [message:wired.error] with [enum:wired.error.message_out_of_sequence].
				
				After this has been completed, the client may send [message:wired.send_ping],
				[message:wired.send_login], [message:wired.user.set_nick], [message:wired.user.set_status]
				or [message:wired.user:set_icon].
			</p7:documentation>
			<p7:reply message="wired.server_info" count="1" use="required" version="2.0" />
		</p7:transaction>
		
		<p7:transaction message="wired.send_ping" originator="both" use="required" version="2.0">
			<p7:documentation>
				May be initiated at any time by either side, and must be responded to.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.ping] should be replied.
			</p7:documentation>
			<p7:reply message="wired.ping" count="1" use="required" version="2.0" />
		</p7:transaction>
		
		<p7:transaction message="wired.send_login" originator="client" use="required" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.login_failed]
				if the user name or password is incorrect.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.

				If the user is banned, [message:wired.banned] should be sent instead.

				Otherwise, [message:wired.login] and [message:wired.account.privileges] should be replied.
				
				After this has completed, [message:wired.error] should no longer be sent be sent
				with [enum:wired.error.message_out_of_sequence].
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.login" count="1" use="required" version="2.0" />
					<p7:reply message="wired.account.privileges" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
				<p7:reply message="wired.banned" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.set_nick" originator="client" version="2.0">
			<p7:documentation>
				Initial desired nick name should be sent before [message:wired.send_login] so
				that other clients see it.

				[message:wired.error] should be replied with [enum:wired.error.permission_denied],
				if [field:wired.account.user.cannot_set_nick] is set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.user_status] to be sent to all users on all chats the
				user is currently on.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.set_status" originator="client" version="2.0">
			<p7:documentation>
				Initial desired status should be sent before [message:wired.send_login] so
				that other clients see it.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.user_status] to be sent to all users on all chats the
				user is currently on.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.set_icon" originator="client" version="2.0">
			<p7:documentation>
				Initial desired icon should be sent before [message:wired.send_login] so
				that other clients see it.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.user_icon] to be sent to all users on all chats the
				user is currently on.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.set_idle" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.user_status] to be sent to all users on all chats the
				user is currently on.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.get_info" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.user.get_info] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.

				Otherwise, [message:wired.user.info] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.user.info" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.disconnect_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.user.disconnect_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.cannot_be_disconnected]
				if [field:wired.account.user.cannot_be_disconnected] is set for the target user\'s
				account.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.user_disconnect] to be sent to all users on all chats the
				user is currently on.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.ban_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.user.ban_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.cannot_be_disconnected]
				if [field:wired.account.user.cannot_be_disconnected] is set for the target user\'s
				account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.user_ban] to be sent to all users on all chats the
				user is currently on.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.user.get_users" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.user.get_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].

				Otherwise, one or more [message:wired.user.user_list] terminated by a single
				[message:wired.user.user_list.done] should be replied. This list should consist of all
				users currently logged in, even those that are not on any chats.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.user.user_list" count="+" use="required" version="2.0" />
					<p7:reply message="wired.user.user_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.chat.join_chat" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.chat_not_found]
				if the chat is not the public chat or the chat has not been created.
				
				[message:wired.error] should be replied with [enum:wired.error.already_on_chat]
				if the user is already on the chat.
				
				[message:wired.error] should be replied with [enum:wired.error.not_invited_to_chat]
				if the chat is not the public chat and the user has not been invited to the chat,
				or did not create the chat.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, one or more [message:wired.chat.user_list] terminated by a single
				[message:wired.chat.list.done] should be replied. If the chat has a topic set,
				[message:wired.chat.topic] should also be replied.
				
				Should cause [message:wired.chat.user_join] to be sent to all users on the chat.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.chat.user_list" count="+" use="required" version="2.0" />
					<p7:reply message="wired.chat.user_list.done" count="1" use="required" version="2.0" />
					<p7:reply message="wired.chat.topic" count="?" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.chat.leave_chat" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.not_on_chat] if the user
				is not currently on the chat.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.chat.user_leave] to be sent to all users on the chat.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.chat.kick_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.chat_not_found]
				if the chat is not the public chat or the chat has not been created.
				
				[message:wired.error] should be replied with [enum:wired.error.not_on_chat] if the user
				or the target user is not currently on the chat.
				
				[message:wired.error] should be replied with [enum:wired.error.permission_denied] if the chat
				is the public chat and [enum:wired.account.chat.kick_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.chat.user_kick] to be sent to all users on the chat.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.chat.set_topic" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.chat_not_found]
				if the chat is not the public chat or the chat has not been created.
				
				[message:wired.error] should be replied with [enum:wired.error.not_on_chat] if the user
				is not currently on the chat.

				[message:wired.error] should be replied with [enum:wired.error.permission_denied] if the chat
				is the public chat and [enum:wired.account.chat.set_topic] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.chat.topic] to be sent to all users on the chat.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.chat.send_say" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.chat_not_found]
				if the chat is not the public chat or the chat has not been created.
				
				[message:wired.error] should be replied with [enum:wired.error.not_on_chat] if the user is
				not currently on the chat.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.chat.say] to be sent to all users on the chat.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.chat.send_me" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.chat_not_found]
				if the chat is not the public chat or the chat has not been created.
				
				[message:wired.error] should be replied with [enum:wired.error.not_on_chat] if the user is
				not currently on the chat.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.chat.me] to be sent to all users on the chat.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.chat.create_chat" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.chat.create_chats] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.chat.chat_created] should be replied.
				
				A chat should be created on the server such that this user can join it.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.chat.chat_created" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.chat.invite_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.chat_not_found]
				if the chat does not exist.
				
				[message:wired.error] should be replied with [enum:wired.error.user_not_found]
				if the user does not exist.
				
				[message:wired.error] should be replied with [enum:wired.error.not_on_chat] if the user is
				not currently on the chat.
				
				[message:wired.error] should be replied with [enum:wired.error.already_on_chat] if the target user
				is already currently on the chat.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.invitation] to be sent to the invited user.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.chat.decline_invitation" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.chat_not_found]
				if the chat does not exist.
				
				[message:wired.error] should be replied with [enum:wired.error.user_not_found]
				if the user does not exist.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.chat.user_decline_invitation] to be sent to all users
				on the chat.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.message.send_message" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.message.send_messages] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.message.message] to be sent to the receiving user.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.message.send_broadcast" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.message.broadcast] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [broadcast:wired.message.broadcast] to be broadcasted to all currently
				logged in users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.get_boards" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.board.board_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.board.board_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.board.get_threads" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.board.thread_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.board.thread_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.board.get_thread" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.board.thread" count="1" use="required" version="2.0" />
					<p7:reply message="wired.board.post_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.board.post_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.add_board" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.rename_board" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.move_board" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.delete_board" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.get_board_info" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.board.board_info" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.board.set_board_info" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.add_thread" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.move_thread" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.delete_thread" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.add_post" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.edit_post" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.delete_post" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.subscribe_boards" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.board.unsubscribe_boards" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.list_directory" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.list_files] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, zero or more [message:wired.file.file_list] terminated by a single
				[message:wired.file.file_list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.file.file_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.file.file_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.get_info" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.get_info] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the file or directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.file.info] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.file.info" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.move" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.move_files] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directories.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the source file or directory, or destination directory does not exist.
				
				[message:wired.error] should be replied with [enum:wired.error.file_exists]
				if the destination file already exists.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.link" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.link_files] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directories.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the source file or directory, or the destination directory does not exist.
				
				[message:wired.error] should be replied with [enum:wired.error.file_exists]
				if the destination file already exists.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.delete" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.delete_files] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the file or directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_deleted] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.set_type" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.set_type] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.set_comment" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.set_comment] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the file or directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.set_executable" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.set_executable] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the file does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.set_label" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.set_label] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the file or directory not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.set_permissions" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.set_permissions] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
				</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.create_directory" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.create_directories] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the parent destination directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.file_exists]
				if the destination directory already exists.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.file.directory_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.search" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.search_files] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, zero or more [message:wired.file.search_list] terminated by a single
				[message:wired.file.search_list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.file.search_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.file.search_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.preview_file" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.file.preview" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.subscribe_directory" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.list_files] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied. After this, the user may receive
				[message:wired.file.directory_changed] and [message:wired.file.directory_deleted]
				messages.
				
				The subscription may be silently dropped if the user\'s account loses the
				[field:wired.account.file.list_files] privilege while subscribed.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.file.unsubscribe_directory" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.list_files] is not set for the user\'s account, or if the user
				does not have applicable permissions for the directory.
				
				[message:wired.error] should be replied with [enum:wired.error.not_subscribed]
				if the user has not previously subscribed to this directory.

				[message:wired.error] should be replied with [enum:wired.error.file_not_found]
				if the directory does not exist.

				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied. After this, the user should no longer
				receive [message:wired.file.directory_changed] and [message:wired.file.directory_deleted]
				messages.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.change_password" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.change_password] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, [message:wired.okay] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.list_users" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.list_accounts] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, one or more [message:wired.account.user_list] terminated by a single
				[message:wired.account.user_list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.account.user_list" count="+" use="required" version="2.0" />
					<p7:reply message="wired.account.user_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.list_groups" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.list_accounts] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, one or more [message:wired.account.group_list] terminated by a single
				[message:wired.account.group_list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.account.group_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.account.group_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.read_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.read_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.account.user] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.account.user" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.read_group" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.read_groups] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.account.group] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.account.group" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.create_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.create_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.

				Otherwise, [message:wired.okay] should be replied.

				Should cause [message:wired.account.accounts_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.create_group" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.create_groups] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, [message:wired.okay] should be replied.

				Should cause [message:wired.account.accounts_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.edit_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.edit_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, [message:wired.okay] should be replied.
				
				If the account name was changed, this should cause [message:wired.account.accounts_changed]
				to be sent out to subscribed users.
				
				If any users are currently logged in using the account, this should cause
				[message:wired.account.privileges] to be sent out to them.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.edit_group" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.edit_groups] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, [message:wired.okay] should be replied.
				
				If the account name was changed, this should cause [message:wired.account.accounts_changed]
				to be sent out to subscribed users.
				
				If any users are currently logged in using an account that is a member of the group,
				this should cause [message:wired.account.privileges] to be sent out to them.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.delete_user" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.delete_users] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.account.accounts_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.account.delete_group" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.delete_groups] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
				
				Should cause [message:wired.account.accounts_changed] to be sent out to subscribed
				users.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.account.subscribe_accounts" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.account.list_accounts] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.okay] should be replied. After this, the user may receive
				[message:wired.account.accounts_changed] messages.
				
				The subscription may be silently dropped if the user\'s account loses the
				[field:wired.account.account.list_accounts] privilege while subscribed.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.account.unsubscribe_accounts" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.file.list_accounts] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.not_subscribed]
				if the user has not previously subscribed to account changes.

				Otherwise, [message:wired.okay] should be replied. After this, the user should no longer
				receive [message:wired.account.accounts_changed] messages.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.transfer.download_file" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.transfer.queue" count="*" use="required" version="2.0" />
					<p7:reply message="wired.transfer.download" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.transfer.upload_file" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.transfer.queue" count="*" use="required" version="2.0" />
					<p7:reply message="wired.transfer.upload_ready" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.transfer.upload_ready" originator="server" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:reply message="wired.transfer.upload" count="1" use="required" version="2.0" />
		</p7:transaction>

		<p7:transaction message="wired.transfer.upload_directory" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.log.get_log" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.log.view_log] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, zero or more [message:wired.log.list] terminated by a single
				[message:wired.log.list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.log.list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.log.list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.log.subscribe" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.log.view_log] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.okay] should be replied. After this, the user may receive
				[message:wired.log.message] messages.
				
				The subscription may be silently dropped if the user\'s account loses the
				[field:wired.account.log.view_log] privilege while subscribed.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.log.unsubscribe" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.log.view_log] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.not_subscribed]
				if the user has not previously subscribed to the log.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.okay] should be replied. After this, the user should no longer
				receive [message:wired.log.message] messages.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="*" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.event.get_first_time" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.events.view_events] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.event.first_time] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.event.first_time" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.event.get_events" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.events.view_events] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, zero or more [message:wired.event.event_list] terminated by a single
				[message:wired.event.event_list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.event.event_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.event.event_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.event.delete_events" originator="client" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.event.subscribe" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.events.view_events] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.okay] should be replied. After this, the user may receive
				[message:wired.event.event] and [message:wired.event.archive] messages.
				
				The subscription may be silently dropped if the user\'s account loses the
				[field:wired.account.events.view_events] privilege while subscribed.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
		
		<p7:transaction message="wired.event.unsubscribe" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.events.view_events] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.not_subscribed]
				if the user has not previously subscribed to events.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.okay] should be replied. After this, the user should no longer
				receive [message:wired.event.event] messages.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="*" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.settings.get_settings" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.settings.get_settings] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.settings.settings] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.settings.settings" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.settings.set_settings" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.settings.set_settings] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, [message:wired.okay] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.banlist.get_bans" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.banlist.get_bans] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, zero or more [message:wired.banlist.list] terminated by a single
				[message:wired.banlist.list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.banlist.list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.banlist.list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.banlist.add_ban" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.banlist.add_bans] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.ban_exists] if the ban
				already exists.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, [message:wired.okay] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.banlist.delete_ban" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.banlist.delete_bans] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.ban_not_found] if the ban
				does not exist.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				[message:wired.error] may be replied with [enum:wired.error.internal_error]
				if an unknown error occurs.
				
				Otherwise, [message:wired.okay] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.tracker.get_categories" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.tracker_not_enabled]
				if the server is not configured to be a tracker.

				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.tracker.list_servers] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, [message:wired.tracker.categories] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.tracker.categories" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.tracker.get_servers" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.tracker_not_enabled]
				if the server is not configured to be a tracker.

				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.tracker.list_servers] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				Otherwise, zero or more [message:wired.tracker.server_list] terminated by a single
				[message:wired.tracker.server_list.done] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:and>
					<p7:reply message="wired.tracker.server_list" count="*" use="required" version="2.0" />
					<p7:reply message="wired.tracker.server_list.done" count="1" use="required" version="2.0" />
				</p7:and>
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.tracker.send_register" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.tracker_not_enabled]
				if the server is not configured to be a tracker.

				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.tracker.register_servers] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.tracker.register] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>

		<p7:transaction message="wired.tracker.send_update" originator="client" version="2.0">
			<p7:documentation>
				[message:wired.error] should be replied with [enum:wired.error.tracker_not_enabled]
				if the server is not configured to be a tracker.

				[message:wired.error] should be replied with [enum:wired.error.not_registered]
				if the server has not previously been registered.
				
				[message:wired.error] should be replied with [enum:wired.error.permission_denied]
				if [field:wired.account.tracker.register_servers] is not set for the user\'s account.
				
				[message:wired.error] should be replied with [enum:wired.error.message_out_of_sequence]
				if sent before [message:wired.client_info].
				
				[message:wired.error] should be replied with [enum:wired.error.invalid_message] if the
				message does not contain all the required parameters.
				
				Otherwise, [message:wired.okay] should be replied.
			</p7:documentation>
			<p7:or>
				<p7:reply message="wired.okay" count="1" use="required" version="2.0" />
				<p7:reply message="wired.error" count="1" use="required" version="2.0" />
			</p7:or>
		</p7:transaction>
     
	</p7:transactions>
	
	<p7:broadcasts>
		<p7:broadcast message="wired.server_info" version="2.0">
			<p7:documentation>
				May be sent at any time to all users.
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.chat.user_join" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.user_leave" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.user_status" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.user_icon" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.user_disconnect" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.user_kick" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.user_ban" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.say" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.me" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.chat.user_decline_invitation" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.chat.invitation" version="2.0">
			<p7:documentation>
				May be sent at any time from any other user.
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.message.message" version="2.0">
			<p7:documentation>
				May be sent at any time from any other user.
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.message.broadcast" version="2.0">
			<p7:documentation>
				May be sent at any time from any other user.
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.board_added" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.board_renamed" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.board_deleted" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.board_info_changed" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.thread_added" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.thread_moved" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.thread_deleted" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>

		<p7:broadcast message="wired.board.thread_changed" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.file.directory_changed" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.file.directory_deleted" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.account.privileges" version="2.0">
			<p7:documentation>
				May be sent at any time to all users.
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.account.accounts_changed" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.log.message" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
		
		<p7:broadcast message="wired.event.event" version="2.0">
			<p7:documentation>
				TBD
			</p7:documentation>
		</p7:broadcast>
        
	</p7:broadcasts>
</p7:protocol>
'