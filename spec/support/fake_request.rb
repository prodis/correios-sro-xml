# encoding: UTF-8

def fake_request_for(response)
  FakeWeb.register_uri(:post,
                       Regexp.new("http://websro.correios.com.br/sro_bin/sroii_xml.eventos"),
                       :status => 200,
                       :body => body_for(response))
end

def body_for(response)
  response
end
