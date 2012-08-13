# encoding: UTF-8

def mock_request_for(response)
  url = Regexp.new("http://websro.correios.com.br/sro_bin/sroii_xml.eventos")
  WebMock::API.stub_request(:post, url).to_return(:status => 200, :body => body_for(response))
end

def body_for(response)
  case response
  when :success_response_one_object
    File.open(File.dirname(__FILE__) + "/responses/success-response-one-object.xml").read
  when :success_response_many_objects
    File.open(File.dirname(__FILE__) + "/responses/success-response-many-objects.xml").read
  when :success_response_many_objects_international
    File.open(File.dirname(__FILE__) + "/responses/success-response-many-objects-international.xml").read
  when :failure_response_not_found
    File.open(File.dirname(__FILE__) + "/responses/failure-response-not-found.xml").read
  else
    response
  end
end
