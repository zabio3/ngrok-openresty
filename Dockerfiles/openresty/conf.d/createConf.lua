if (ngx.var.host == nil and ngx.var.arg_ngrok_fqdn == nil and ngx.var.arg_origin_ip_url == nil) then
    ngx.say(400);
else
    path = '/etc/nginx/conf.d/'
    foldername = ngx.var.host
    os.execute("mkdir " .. path..foldername)
    file = io.open(path..foldername..'/'..ngx.var.arg_ngrok_fqdn..'.conf', "w")
    file:write([[
server {
  listen       80;
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

    ngx.say(200);
end

-- そもそもリロードに失敗している。権限周りを含めてみなす必要あり
--io.popen('/usr/local/openresty/bin/openresty -s reload');
--io.popen('/usr/local/openresty/nginx/sbin/nginx -s reload');