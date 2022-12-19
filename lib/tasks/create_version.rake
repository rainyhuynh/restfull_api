namespace :version do
    task :create do
        desc "create VERSION.  Use MAJOR_VERSION, MINOR_VERSION, BUILD_VERSION to override defaults"

        version_file = "#{Rails.root}/config/initializers/version.rb"

        major = ENV["MAJOR_VERSION"] || 3
        minor = ENV["MINOR_VERSION"] || 0
        build = (ENV["BUILD_VERSION"] || 0).to_i + 1 #`git describe --always --tags`
        version_string = "VERSION = #{[major.to_s, minor.to_s, build.to_s]}\n"
        File.open(version_file, "w") {|f| f.print(version_string)}
        $stderr.print(version_string)
    end
end
