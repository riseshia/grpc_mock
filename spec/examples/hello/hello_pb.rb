# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: hello.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "hello.HelloRequest" do
    optional :msg, :string, 1
  end
  add_message "hello.HelloResponse" do
    optional :msg, :string, 1
  end
  add_message "hello.HelloStreamRequest" do
    optional :msg, :string, 1
  end
  add_message "hello.HelloStreamResponse" do
    optional :msg, :string, 1
  end
end

module Hello
  HelloRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("hello.HelloRequest").msgclass
  HelloResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("hello.HelloResponse").msgclass
  HelloStreamRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("hello.HelloStreamRequest").msgclass
  HelloStreamResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("hello.HelloStreamResponse").msgclass
end
