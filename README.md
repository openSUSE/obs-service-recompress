# recompress (OBS source service) 

This is an [Open Build Service](http://openbuildservice.org/) source service. It supports to compress, uncompress or recompress files from or to

* none : No Compression
* gz   : Gzip Compression
* bz2  : Bzip2 Compression
* xz   : XZ Compression
* zstd : Zstd Compression

This is the git repository for [openSUSE:Tools/obs-service-recompress](https://build.opensuse.org/package/show/openSUSE:Tools/obs-service-recompress). The authoritative source is https://github.com/openSUSE/obs-service-recompress

The service can be used in combination with other services like [download_files](https://github.com/openSUSE/obs-service-download_files), [tar_scm](https://github.com/openSUSE/obs-service-tar_scm), [extract_file](https://github.com/openSUSE/obs-service-extract_file) or [set_version](https://github.com/openSUSE/obs-service-set_version) e.g. within the [GIT integration](https://en.opensuse.org/openSUSE:Build_Service_Concept_SourceService#Example_2:_GIT_integration) workflow.

