# Generated by the protocol buffer compiler.  DO NOT EDIT!
# Source: hello.proto for package 'hello'

require 'grpc'
require 'examples/hello/hello_pb'

module Hello
  module Hello
    class Service

      include GRPC::GenericService

      self.marshal_class_method = :encode
      self.unmarshal_class_method = :decode
      self.service_name = 'hello.hello'

      rpc :Hello, HelloRequest, HelloResponse
      rpc :HelloServerStream, HelloRequest, stream(HelloStreamResponse)
      rpc :HelloClientStream, stream(HelloStreamRequest), HelloResponse
      rpc :HelloStream, stream(HelloStreamRequest), stream(HelloStreamResponse)
    end

    Stub = Service.rpc_stub_class
  end
end