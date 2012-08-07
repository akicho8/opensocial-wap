# -*- coding: utf-8 -*-
require 'uri'

module OpensocialWap
  module OAuth
    class ClientHelper

      attr_reader :oauth_helper, :url

      # Assuming that API endpoint is 'http://api.example.com/rest/', API URL is generated as follows.
      #
      # OpensocialWap::OAuth::ClientHelper(oauth_helper, 'people', '@me', '@self', :format => 'atom', :fields => 'gender,address')
      #   => "http://api.example.com/rest/people/@me/@self?format=atom&fields=gender,address"
      #
      def initialize(oauth_helper, *args)
        @oauth_helper = oauth_helper

        # 最後の引数が Hash であれば、クエリパラメータとする.
        query_parameters = {}
        if args.size > 0
          if args[-1].is_a? Hash
            query_parameters = args.pop
          end
        end

        # URLを構築.
        @url = query_parameters.delete("api_endpoint") || query_parameters.delete(:api_endpoint) || @oauth_helper.api_endpoint.dup
        @url << '/' if @url[-1] != '/'
        @url << args.join('/')
        unless query_parameters.empty?
          @url << "?#{::OAuth::Helper.normalize(query_parameters)}"
        end
      end

      def uri
        @uri ||= URI.parse(@url)
      end

      # Authorization ヘッダの値を計算して返す.
      def authorization_header(api_request, options = {})
        options[:request_uri] = @url
        @oauth_helper.authorization_header(api_request, options)
      end
    end
  end
end
