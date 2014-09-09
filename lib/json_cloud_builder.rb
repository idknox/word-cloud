require_relative "word_cloud"
require "fileutils"
require "tempfile"

class JsonCloudBuilder
  def initialize(file)
    @file = file
  end

  def make_cloud
    string = file_to_string
    word_cloud = WordCloud.new(string)
    write_file(word_cloud.make_cloud)
  end

  private

  def file_to_string
    file = File.open(@file, "rb")
    file.read
  end

  def write_file(cloud_hash)
    tmp = Tempfile.new("temp")
    tmp << cloud_hash
    tmp.close
    FileUtils.mv(tmp.path, "./bin/#{@file.split("/").last}_for_cloud")
  end

end