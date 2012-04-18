# encoding: UTF-8

def fake_request_for(response)
  FakeWeb.register_uri(:post,
                       Regexp.new("http://websro.correios.com.br/sro_bin/sroii_xml.eventos"),
                       :status => 200,
                       :body => body_for(response))
end

def body_for(response)
  case response
  when :success_response_one_object
    File.open(File.dirname(__FILE__) + "/responses/success-response-one-object.xml").read
  when :success_response_many_objects
    File.open(File.dirname(__FILE__) + "/responses/success-response-many-objects.xml").read
  when :success_response_many_objects_international
    File.open(File.dirname(__FILE__) + "/responses/success-response-many-objects-international.xml").read
  else
    response
  end
end
