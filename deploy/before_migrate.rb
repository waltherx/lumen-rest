Chef::Log.info("Running before migrate tasks")

user "root"

storage_path = "/srv/www/api_server/shared/storage/"

paths = [
    "app",
    "framework/cache",
    "framework/session",
    "framework/views",
    "logs"
]

paths.each do |path|
    create_path = storage_path + path;
    execute "mkdir -p #{create_path}"
end

execute "chown -R deploy:www-data #{storage_path}"
execute "chmod -R 755 #{storage_path}"

::File.file?("/srv/www/api_server/current/artisan") do
    execute "chmod ug+x /srv/www/api_server/current/artisan"

    #execute "/srv/www/api_server/current/artisan doctrine:schema:update"
    #execute "/srv/www/api_server/current/artisan doctrine:generate:proxies"
end
