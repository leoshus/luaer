local producer = nil
function producer()
  local i = 0
  while true do
    i = i + 1
    send(i)
  end
end


function send(data) 
  print("send data =" .. data)
  coroutine.yield(data);
end

function consumer()
  while true do
    local result = receive()
    print("recevice data=" .. result);
  end
end

function receive()
  local status ,value = coroutine.resume(producer)
  return value
end
producer = coroutine.create(producer)
consumer()