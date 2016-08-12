namespace :docker do

  desc "rebuild and swap fx container"
  task :rebuild do
    sh 'docker build -t fx .'
    sh 'docker stop fx; true'
    sh 'docker rm fx; true'
    sh 'docker run -d --name fx --link postgres:postgres -e FX_DATABASE_PASSWORD="fx-password" fx'
  end

  desc "dump fx tables and install them locally"
  task :pull_fx do
    sh 'docker rm fx-dump; true'
    sh 'docker run -it --name fx-dump -v tmp:/tmp/data --link postgres:postgres postgres pg_dump fx_production -h postgres -U fx -W -a -t quote_sets -t quotes -f /tmp/data/fx.sql'
    sh 'docker rm fx-dump; true'
    sh 'docker run -it --name fx-dump -v tmp:/tmp/data postgres cat /tmp/data/fx.sql | gzip > tmp/fx.sql.gz'
    sh 'docker rm fx-dump; true'
    sh 'rake db:reset'
    sh 'cat tmp/fx.sql.gz|gunzip|rails dbconsole'
    sh 'rm tmp/fx.sql.gz'
  end
end
