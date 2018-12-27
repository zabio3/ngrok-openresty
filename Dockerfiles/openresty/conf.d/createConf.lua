function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

if (ngx.var.host == nil and ngx.var.arg_ngrok_fqdn == nil and ngx.var.arg_origin_ip_url == nil) then
    ngx.say(400);
else
    path = '/etc/nginx/conf.d/'
    foldername = ngx.var.host
    filepath = path..foldername..'/'..ngx.var.arg_ngrok_fqdn..'.conf'

    if file_exists(filepath) == false then
        os.execute("mkdir " .. path..foldername)
        file = io.open(filepath, "w")
        file:write([[
server {
  listen       8080;
  server_name  ]]..ngx.var.arg_ngrok_fqdn..[[;
  access_log /dev/stdout;

  location / {
    root   html;
    index  index.html index.htm;
    default_type 'text/plain';

    if ($request_uri = /createConf) {
      return 302;
    }

    # cache setting
    more_set_headers "Cache-Control: no-cache";
    more_set_headers "Expires: -1";

    sub_filter_once off;
    sub_filter_types text/javascript;
    sub_filter_types text/plain;
    sub_filter_types text/css;
    sub_filter_types text/csv;
    sub_filter_types application/xhtml+xml;

    sub_filter    '/]]..ngx.var.host..[[' '/]]..ngx.var.arg_ngrok_fqdn..[[';

    proxy_pass ]]..ngx.var.arg_origin_ip_url..[[;

    # add header
    proxy_set_header Accept-Encoding "";
    proxy_set_header Host "]]..ngx.var.host..[[";
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}]])
        file:close()
        io.popen('/usr/local/openresty/bin/openresty -s reload');
        ngx.say('create file');
    else
        ngx.say('exist file');
    end
end
