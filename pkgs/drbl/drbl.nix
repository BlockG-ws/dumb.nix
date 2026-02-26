{ lib
, stdenv
, fetchFromGitHub
, makeWrapper
, patch
, bash
, coreutils
, perl
, bc
, iproute2
, iputils
, net-tools
, util-linux
, gawk
, gnused
, gnugrep
, findutils
, gnutar
, gzip
, bzip2
, xz
, cpio
, rsync
, openssh
, wget
, curl
, which
, file
, xxd
}:

stdenv.mkDerivation rec {
  pname = "drbl";
  version = "5.8.1";

  src = fetchFromGitHub {
    owner = "stevenshiau";
    repo = "drbl";
    rev = "v${version}";
    hash = "sha256-8mX8rhyaRI3YPnom/qisIC4asXL15OII7v7LtJbYO5o=";
  };

  patches = [
    ./usrbin.patch
  ];

  nativeBuildInputs = [
    patch
    makeWrapper
    xxd  # for building fail-mbr.bin
  ];

  # 根据 PKGBUILD，核心依赖只有 perl 和 bc
  # 但运行时需要更多工具
  propagatedBuildInputs = [
    perl
    bc
    bash
    coreutils
    iproute2
    iputils
    net-tools
    util-linux
    gawk
    gnused
    gnugrep
    findutils
    gnutar
    gzip
    bzip2
    xz
    cpio
    rsync
    openssh
    wget
    curl
    which
    file
  ];

  # 修复 shebang
  postPatch = ''
    patchShebangs --build .
  '';

  makeFlags = [
    "DESTDIR=${placeholder "out"}"
  ];

  postInstall = ''
    # 修复安装后的脚本 shebang
    patchShebangs "$out"
    
    # 修复硬编码的 /etc/drbl 路径为实际的 nix store 路径
    for f in $(find "$out" -type f); do
      if file "$f" | grep -q "text"; then
        sed -i "s|/etc/drbl|$out/etc/drbl|g" "$f" || true
        sed -i "s|/usr/share/drbl|$out/usr/share/drbl|g" "$f" || true
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
    
    # 为所有脚本注入依赖和环境变量
    for dir in "$out"/usr/bin "$out"/usr/sbin "$out"/usr/share/drbl/bin "$out"/usr/share/drbl/sbin; do
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
              bash coreutils perl bc
              iproute2 iputils net-tools util-linux
              gawk gnused gnugrep findutils gnutar gzip bzip2 xz cpio
              rsync openssh wget curl which file
            ]} \
            --set-default DRBL_SCRIPT_PATH "$out/usr/share/drbl"
        fi
      done
    done
  '';

  meta = with lib; {
    description = "Diskless Remote Boot in Linux: manage the deployment of the GNU/Linux operating system across many clients";
    longDescription = ''
      DRBL (Diskless Remote Boot in Linux) provides a diskless or
      systemless environment for client machines. It works on various
      Linux distributions and uses distributed hardware resources,
      making it possible for clients to fully access local hardware.
      It also includes support for Clonezilla.
    '';
    homepage = "https://drbl.org/";
    license = licenses.gpl2Only;
    platforms = platforms.linux;
    maintainers = [ ];
  };
}
