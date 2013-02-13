require './lib/base'

task :default => [:spritify]

desc "Make a css sprite from images in input folder"
task :spritify => [:has_imagemagick, :has_output_folder] do
  files = FileList['input/*.png', 'input/*.jpg']

  firstFile = file_name(files[0].split('/')[1])
  outputname = "output/#{firstFile['name']}_output.#{firstFile['ext']}"

  execute "convert #{files.to_s} +append #{outputname}"
end

desc "resize images in input folder"
task :resize => [:has_imagemagick, :has_output_folder] do
  files = FileList['input/*.png', 'input/*.jpg']


  new_size = ask("what size do you want to resize them to? (original size: #{get_image_size(files[0])})")

  f = file_name(files[0].split('/')[1])

  execute "convert -resize #{new_size} #{files.to_s} output/#{f['name']}_#{new_size}_%d.#{f['ext']}"
end

desc "crop files in input folder"
task :crop => [:has_imagemagick, :has_output_folder] do

  files = FileList['input/*.png', 'input/*.jpg']

  size = ask("What size do you want to crop to? (original size: #{get_image_size(files[0])})")
  gravity = ask("What gravity e.g. north,northeast...", "center")

  f = file_name(files[0].split('/')[1])

  execute "convert -gravity #{gravity} -extent #{size} #{files.to_s} output/#{f['name']}_#{size}_%d.#{f['ext']}"
end

desc "move output images to input inorder to run more tasks"
task :do_more do
  vNo = 0
  while Dir["version#{vNo}"].length > 0 do
    vNo += 1;
  end
  execute "mv input version#{vNo}"
  execute "mv output input"
  execute "mkdir output"
end

desc "start a new project (cleans out all files from previous manipulations)"
task :clean do
  execute "rm -rf version*/ input/ output/"
  execute "mkdir input output"
end

task :has_imagemagick do
  imageMagiclocation = %x[which convert]

  if $?.exitstatus == 1
    puts "Imagemagick is required"
    puts "Install with apt-get install imagemagick"
    puts "To install without admin rights follow steps 1-9 in this guide http://scottiestech.info/2010/05/18/installing-imagemagick-from-source-on-ubuntu/"
    exit 1
  end
end

task :has_output_folder do
  if Dir["output"].length > 0
    execute "mkdir output"
  end
end

def file_name(file)
  a = file.split('.')
  return {"name" => a[a.length-2], "ext" => a[a.length-1]}
end

def get_image_size(file)
  IO.popen("identify #{file}").gets.split(' ')[2]
end


