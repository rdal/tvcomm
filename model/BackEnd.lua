-------------------------------------------------------------------------------------
---- Class: BackEnd
----
---- This is the base class for Back End object
----
---- | Date        | Author                  | Description
----
----  12/19/2008     Rafael Donato             Initial Creation
----  01/08/2009     Rafael Donato             Adaption to invoke TVComm Socket class, instead of Lua Socket class
----
---------------------------------------------------------------------------------------
require("util/XMLParser")
require("util/Socket")

BackEnd = {}
backendmt = {}

function BackEnd:new()

    local instance = {}
    setmetatable(instance, backendmt) -- Associate this BackEnd object with backendmt metatable

    --load namespace
    instance.socket = Socket:new()

    return instance

end

-- This function parser the xml response looking for the <return> tag value
function BackEnd:authenticate(login,password)
    ret = false

    local host = "www.nats.inf.br"
    local port = 80

    -- Set up the first XML string
    local XML = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:tns=\"http://".. host .."/soap/CustomerName\" xmlns:types=\"http://".. host .."/soap/CustomerName/encodedTypes\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\"><soap:Body soap:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><q1:getCustomerName xmlns:q1=\"http://".. host .."/webservices\"><input xsi:type=\"xsd:string\">rdal</input></q1:getCustomerName></soap:Body></soap:Envelope>\n\n\n\n\n\n\n\n\n\n\n"


    header = "POST /webservices/server.php HTTP/1.1\n"
    header = header .. "Host: ".. host .."\n"
    header = header .. "Content-Length: "..string.len(XML).."\n"
    header = header .. "Content-Type: text/xml\n"
    header = header .. "\n"

    data = header .. XML

    -- Open the socket
    self.socket:connect(host, port)

    -- Send the XML string
    self.socket:send(data)

    -- Receive the response from server
    str = self.socket:receive()

    -- Close the socket
    self.socket:close()

    xmlParser = XMLParser:new()
    str = xmlParser:parseReturnValue(str)

    print(str)

    return ret
end

-- The metatable to create callbacks
backendmt.__index = BackEnd -- redirect queries to BackEnd table
