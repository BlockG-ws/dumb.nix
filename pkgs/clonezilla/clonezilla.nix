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
, gocryptfs  # 替代 ecryptfs（已被移除）
, screen
, perl
, cifs-utils
, netcat-openbsd
, net-tools
, which
, gnused
, gnugrep
}:

stdenv.mkDerivation rec {
  pname = "clonezilla";
  version = "5.14.5";

  src = fetchgit {
    url = "https://github.com/stevenshiau/clonezilla.git";
    rev = "v${version}";
    hash = "sha256-uvHe2Bq2NAAXZvDNBhCYAHNkKpdQPV0Q0mKsVTTRVKI=";
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
    gocryptfs  # 替代 ecryptfs（已被移除）
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
    
    # 修复脚本中 drbl 的硬编码路径
    for f in "$out"/usr/bin/*; do
      if [ -f "$f" ] && head -1 "$f" | grep -q "^#!"; then
        # 替换 /usr/share/drbl 路径为实际的 drbl 包路径
        sed -i "s|/usr/share/drbl|${drbl}/usr/share/drbl|g" "$f"
        sed -i "s|/etc/drbl|${drbl}/etc/drbl|g" "$f"
      fi
    done
    
    # 创建 bin 目录并复制可执行文件
    mkdir -p "$out/bin"
    if [ -d "$out/usr/bin" ]; then
      for f in "$out"/usr/bin/*; do
        if [ -f "$f" ]; then
          cp "$f" "$out/bin/" || true
        fi
      done
    fi
    
    # 为脚本注入依赖和环境变量
    for dir in "$out"/bin "$out"/usr/bin "$out"/usr/sbin; do
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
              gocryptfs screen cifs-utils netcat-openbsd net-tools which gnused gnugrep
            ]} \
            --set-default DRBL_SCRIPT_PATH "${drbl}/usr/share/drbl" \
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
