# -*- coding: utf-8 -*-
require 'spec_helper'

describe OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxy do

  it "signature_base_stringが正しく構築できること" do
    pending "TODO:値をセット"

    uri = 'http://example.com/?opensocial_app_id=877&opensocial_owner_id=23&sample_key=sample_value'
    opts = {
      :method => "POST",
      :params => "a=b&c=d",
      :input => "_method=put&var%5Bkey%5D=123"
    }
    env = ::Rack::MockRequest.env_for(uri, opts)
    request = ::Rack::Request.new(env)

    request_proxy = OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxy.new(request)
    puts request_proxy.signature_base_string.should == ''

  end

end
