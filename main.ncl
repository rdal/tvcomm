<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="nclClicks" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">

<head>

<regionBase>
	<region id="rgFundo" left="14.8%" top="12%" width="720" height="480" zIndex="0"/>
	<region id="rgVideo" left="14.8%" top="12%" width="720" height="480" zIndex="1">
		<region id="rgAreaLimite" left="10%" top="10%" width="576" height="384" zIndex="1"/>
	</region>
</regionBase>

<descriptorBase>
	<descriptor id="dsVideo" region="rgVideo">
		<descriptorParam name="soundLevel" value="1" />
	</descriptor>
	<descriptor id="dsFundo" region="rgFundo"/>

	<descriptor id="dsAreaLimite"  region="rgAreaLimite" focusIndex="luaIdx">
		<descriptorParam name="transparency" value="90%"/>
		<descriptorParam name="chromakey" value="black"/>
	</descriptor>
</descriptorBase>

<connectorBase>
		
	<causalConnector id="onBeginStart">
		<connectorParam name="var"/>
		<simpleCondition role="onBegin"/>
		<compoundAction operator="seq">
			  <simpleAction role="start" max="unbounded"/>
			 <simpleAction role="set" value="$var"/>
		</compoundAction>
	</causalConnector>
	
	<causalConnector id="onBeginStartlua">
		<simpleCondition role="onBegin"/>
		<compoundAction operator="seq">
			  <simpleAction role="start" max="unbounded"/>
		</compoundAction>
	</causalConnector>
	
	<causalConnector id="onBeginStoplua">
		<simpleCondition role="onBegin"/>
		<compoundAction operator="seq">
			  <simpleAction role="stop" max="unbounded"/>
		</compoundAction>
	</causalConnector>
	  
	<causalConnector id="InicioResize">
  		<connectorParam name="bounds"/>
  		<simpleCondition role="onBegin"/>
  		<compoundAction operator="seq">
     		<simpleAction role="set" value="$bounds"/>
  		</compoundAction>
	   </causalConnector>
	
	<causalConnector id="FinalRisize">
	<connectorParam name="bounds"/>
	<simpleCondition role="onEnd"/>
	<compoundAction operator="seq">
		<simpleAction role="set" value="$bounds"/>
	</compoundAction>
	</causalConnector>			 
	  
</connectorBase>

</head>

<body>
    <port id="entryPoint" component="Video"/>

    <media type="application/x-ginga-settings" id="programSettings">
        <property name="currentKeyMaster" value="luaIdx"/>
    </media>

    <media id="lua" src="tvcomm.lua" descriptor="dsAreaLimite">
        <area id="startresize"/>
		<area id="stopresize"/>
    </media>
    <media descriptor="dsVideo" src="images/video.png" type="image/png" id="Video">
		<property name="bounds" />
	</media>
	<media descriptor="dsFundo" src="images/fundo.png" type="image/png" id="Fundo"/>

    <link xconnector="onBeginStart">
        <bind role="onBegin" component="Video" />
        <bind role="start" component="lua"/>
        <bind component="programSettings" interface="currentKeyMaster" role="set">
            <bindParam name="var" value="luaIdx"/>
        </bind>
    </link>
	
	<link xconnector="onBeginStartlua">
		<bind role="onBegin" component="lua" interface="startresize"/>
		<bind role="start" component="Fundo"/>
	</link>
	
	<link xconnector="onBeginStoplua">
		<bind role="onBegin" component="lua" interface="stopresize"/>
		<bind role="stop" component="Fundo"/>
	</link>
	
	<link id="VideoFundo_start" xconnector="InicioResize">
			<bind component="Fundo" role="onBegin" />
			<bind component="Video" interface="bounds" role="set">
				<bindParam name="bounds" value="49.5%,19.1%,288,192" />
				<!-- As dimensões de bounds são: left, top, width, height -->
			</bind>	
		</link>
	
		<!-- Finaliza Resize -->
		<link id="VideoFundo_stop" xconnector="FinalRisize">
			<bind component="Fundo" role="onEnd"/>
			<bind component="Video" interface="bounds" role="set">
				<bindParam name="bounds" value="14.8%,12%,720,480" />
			</bind>	
		</link>
</body>

</ncl>
