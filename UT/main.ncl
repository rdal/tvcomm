<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="nclClicks" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<head>

<regionBase>
    <region width="50%"  height="50%"  right="10%" top="25%" id="rgLua"/>
</regionBase>

<descriptorBase>
    <descriptor id="dsLua" region="rgLua" focusIndex="luaIdx"/>
</descriptorBase>

<connectorBase>
	<causalConnector id="onBeginStart">
		<simpleCondition role="onBegin"/>
		<simpleAction role="start"/>
	</causalConnector>
</connectorBase>

</head>

<body>
    <port id="entryPoint" component="lua"/>

	<media type="application/x-ginga-settings" id="programSettings">
		<property name="currentKeyMaster" value="luaIdx"/>
	</media>

    <media id="lua" src="TextBoxUT.lua" descriptor="dsLua"/>

</body>

</ncl>
