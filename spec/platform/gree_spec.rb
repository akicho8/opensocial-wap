# -*- coding: utf-8 -*-
require 'spec_helper'

describe OpensocialWap::Platform do
  describe "gree" do
    it "sandbox用に、GREE用の初期化が正しく行えること(セッションOFF)" do
      c = Rails::Application::Configuration.new
      OpensocialWap::Platform.gree(c) do
        consumer_key '(consumer_key)'
        consumer_secret '(consumer_secret)'
        sandbox true
        session false
      end

      c.opensocial_wap.oauth.helper_class.should == OpensocialWap::OAuth::Helpers::BasicHelper
      c.opensocial_wap.oauth.helper_class.proxy_class.should == OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxy
      c.opensocial_wap.oauth.helper_class.consumer_key.should == '(consumer_key)'
      c.opensocial_wap.oauth.helper_class.consumer_secret.should == '(consumer_secret)'
      c.opensocial_wap.oauth.helper_class.api_endpoint.should == 'http://os-sb.gree.jp/api/rest/'
      c.opensocial_wap.url.container_host == 'mgadget-sb.gree.jp'
      c.opensocial_wap.url.default.should == {:format => :query, :params => { :guid => 'ON' }}
      c.opensocial_wap.url.redirect.should == {:format => :local}
      c.opensocial_wap.url.public_path.should == {:format => :local}
      c.opensocial_wap.session_id.should_not == :parameter
    end

    it "本番用に、GREE用の初期化が正しく行えること(セッションON)" do
      c = Rails::Application::Configuration.new
      OpensocialWap::Platform.gree(c) do
        consumer_key '(consumer_key)'
        consumer_secret '(consumer_secret)'
        sandbox false
        session true
      end

      c.opensocial_wap.oauth.helper_class.should == OpensocialWap::OAuth::Helpers::BasicHelper
      c.opensocial_wap.oauth.helper_class.proxy_class.should == OpensocialWap::OAuth::RequestProxy::OAuthRackRequestProxy
      c.opensocial_wap.oauth.helper_class.consumer_key.should == '(consumer_key)'
      c.opensocial_wap.oauth.helper_class.consumer_secret.should == '(consumer_secret)'
      c.opensocial_wap.oauth.helper_class.api_endpoint.should == 'http://os.gree.jp/api/rest/'
      c.opensocial_wap.url.container_host == 'mgadget.gree.jp'
      c.opensocial_wap.url.default.should == {:format => :query, :params => { :guid => 'ON' }}
      c.opensocial_wap.url.redirect.should == {:format => :local}
      c.opensocial_wap.url.public_path.should == {:format => :local}
      c.opensocial_wap.session_id.should == :parameter
    end
  end
end
