require 'grpc'

require 'grpc_mock/errors'

module GrpcMock
  class GrpcStubAdapter
    # To make hook point for GRPC::ClientStub
    # https://github.com/grpc/grpc/blob/bec3b5ada2c5e5d782dff0b7b5018df646b65cb0/src/ruby/lib/grpc/generic/service.rb#L150-L186
    class AdapterClass < GRPC::ClientStub
      def request_response(method, request, *args)
        unless GrpcMock::GrpcStubAdapter.enabled?
          return super
        end

        mock = GrpcMock.stub_registry.response_for_request(method, request)
        if mock
          mock
        elsif GrpcMock.config.allow_net_connect
          super
        else
          raise NetConnectNotAllowedError, method
        end
      end

      def client_streamer(method, requests, *args)
        unless GrpcMock::GrpcStubAdapter.enabled?
          return super
        end

        r = requests.to_a        # XXX
        mock = GrpcMock.stub_registry.response_for_request(method, r)
        if mock
          mock
        elsif GrpcMock.config.allow_net_connect
          super
        else
          raise NetConnectNotAllowedError, method
        end
      end

      def server_streamer(method, request, *args)
        unless GrpcMock::GrpcStubAdapter.enabled?
          return super
        end

        mock = GrpcMock.stub_registry.response_for_request(method, request)
        if mock
          mock
        elsif GrpcMock.config.allow_net_connect
          super
        else
          raise NetConnectNotAllowedError, method
        end
      end

      def bidi_streamer(method, requests, *args)
        unless GrpcMock::GrpcStubAdapter.enabled?
          return super
        end

        r = requests.to_a        # XXX
        mock = GrpcMock.stub_registry.response_for_request(method, r)
        if mock
          mock
        elsif GrpcMock.config.allow_net_connect
          super
        else
          raise NetConnectNotAllowedError, method
        end
      end
    end
    GRPC.send(:remove_const, :ClientStub)
    GRPC.send(:const_set, :ClientStub, AdapterClass)

    def self.disable!
      @enabled = false
    end

    def self.enable!
      @enabled = true
    end

    def self.enabled?
      @enabled
    end

    def enable!
      GrpcMock::GrpcStubAdapter.enable!
    end

    def disable!
      GrpcMock::GrpcStubAdapter.disable!
    end

    # class Streamer
    #   include Enumerable

    #   # @param path [String]
    #   # @param requests [Enumerable]
    #   def initialize(path, requests)
    #     @path = path
    #     @requests = requests
    #   end

    #   def each
    #     @requests.each do |req|
    #       mock = GrpcMock.stub_registry.response_for_request(@path, req)
    #       if mock
    #         mock
    #       else
    #         req
    #       end
    #     end
    #   end
    # end
  end
end
