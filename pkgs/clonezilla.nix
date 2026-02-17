{ lib
, stdenv
, fetchgit
, patch
, makeWrapper
, bash
, coreutils
, drbl
, partclone
, ntfs3g
, partimage
, pigz
, sshfs
, parted
, gptfdisk
, dosfstools
, gzip
, bzip2
, pbzip2
, lbzip2
, lrzip
, xz
, pixz
, lzop
, ecryptfs
, screen
, perl
, cifs-utils
, netcat-openbsd
, net-tools
, which
}:

stdenv.mkDerivation rec {
  pname = "clonezilla";
  version = "5.14.5";

  src = fetchgit {
    url = "https://github.com/stevenshiau/clonezilla.git";
    rev = "v${version}";
    hash = "sha256-N9HciJzHLB8t+AGe3t2BHSf+LyaTSGI2iNLKJK6VTf0=";
  };

  patches = [
    ./usrbin.patch
  ];

  nativeBuildInputs = [
    patch
    makeWrapper
  ];

  propagatedBuildInputs = [
    drbl
    partclone
    ntfs3g
    partimage
    pigz
    sshfs
    parted
    gptfdisk
    dosfstools
    gzip
    bzip2
    pbzip2
    lbzip2
    lrzip
    xz
    pixz
    lzop
    ecryptfs
    screen
    perl
    cifs-utils
    netcat-openbsd
    net-tools
    which
  ];

  # 修复 shebang 和注入依赖
  postPatch = ''
    patchShebangs --build .
  '';

  postInstall = ''
    # 修复安装后的脚本 shebang
    patchShebangs "$out"
    
    # 为脚本注入依赖
    for dir in "$out"/bin "$out"/sbin "$out"/usr/bin "$out"/usr/sbin; do
      [ -d "$dir" ] || continue
      
      for f in "$dir"/*; do
        [ -f "$f" ] || continue
        
        # 跳过二进制文件
        if file "$f" | grep -q "ELF"; then
          continue
        fi
        
        # 检查是否是脚本
        if head -1 "$f" 2>/dev/null | grep -q "^#!"; then
          wrapProgram "$f" \
            --prefix PATH : ${lib.makeBinPath [
              bash coreutils perl
              drbl partclone ntfs3g partimage pigz sshfs parted gptfdisk
              dosfstools gzip bzip2 pbzip2 lbzip2 lrzip xz pixz lzop
              ecryptfs screen cifs-utils netcat-openbsd net-tools which
            ]}
        fi
      done
    done
  '';

  installFlags = [
    "DESTDIR=${placeholder "out"}"
  ];

  meta = with lib; {
    description = "ncurses partition and disk imaging/cloning program";
    longDescription = ''
      Clonezilla is a free and open-source disk cloning and imaging solution.
      It helps you to do bare-metal backup and recovery, to clone disks, and
      to recover from disaster.
    '';
    homepage = "https://clonezilla.org/";
    license = licenses.gpl2Only;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}
