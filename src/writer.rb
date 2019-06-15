class Writer 
    def self.write(read_path, write_path, &prc)
        read_path && read= File.open(read_path)
        write_path && write = File.open(write_path, "w")

        prc.call(read, write)

        write.close
    end
end