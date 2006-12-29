require 'tempfile'

Tempfile.class_eval do
  # overwrite so tempfiles use the extension of the basename.  important for rmagick and image science
  def make_tmpname(basename, n)
    ext = nil
    sprintf("%s%d-%d%s", basename.gsub(/\.\w+$/) { |s| ext = s; '' }, $$, n, ext)
  end
end

ActiveRecord::Base.send(:extend, Technoweenie::AttachmentFu::ActMethods)
Technoweenie::AttachmentFu.tempfile_path = ATTACHMENT_FU_TEMPFILE_PATH if const_defined?(:ATTACHMENT_FU_TEMPFILE_PATH)
FileUtils.mkdir_p Technoweenie::AttachmentFu.tempfile_path