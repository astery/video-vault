module Features
  module PathHelpers
    def file_fixtures_dir _path=''
      File.join Rails.root, 'features/file-fixtures', _path
    end
  end
end
