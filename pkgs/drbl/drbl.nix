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
}:

stdenv.mkDerivation rec {
  pname = "drbl";
  version = "5.8.1";

  src = fetchFromGitHub {
    owner = "stevenshiau";
    repo = "drbl";
    rev = "v${version}";
    hash = "sha256-xkOlRNq9ejWO63oDHej2ZXHA72UrJhVEkjwC8leD93c=";
  };

  patches = [
    ./usrbin.patch
  ];

  nativeBuildInputs = [
    patch
    makeWrapper
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
    
    # 为所有脚本注入依赖
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
            ]}
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
