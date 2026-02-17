{ pkgs, ... }:
{
  # 字体配置
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji  # 已重命名（原 noto-fonts-emoji）
      source-han-sans
      source-han-serif
      nerd-fonts.fira-code
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Noto Sans Mono CJK SC" "FiraCode Nerd Font" ];
        sansSerif = [ "Noto Sans CJK SC" ];
        serif = [ "Noto Serif CJK SC" ];
      };
    };
  };
}