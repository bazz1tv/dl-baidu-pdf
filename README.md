# dl-baidu-pdf

This is a compilation of tools encapsulated together to form a *nix package that enables downloading a document from wenku.baidu.com to a PDF. The only downside is that the resulting PDF will not be text-parsable.

## How to Install

### Pre-Requisite Packages

* imagemagick (convert)
* poppler (pdfunite)

Gentoo: `sudo emerge -av imagemagick poppler`

Now, run the `install.sh` script. By default, it will install all scripts to /usr/local/bin, but you may use `-i` to specify an alternative location. The encapsulation scripts expect the install directory to be in `$PATH`

## How to Use

After installing pre-requisite packages and using the install.sh script, you can download a baidu document by doing, as an example:

`dl-baidu-pdf.sh -o derp.pdf http://wenku.baidu.com/view/27f176556c85ec3a86c2c51c.html?re=view`

Run `dl-baidu-pdf.sh` without arguments for help

Credz to original authors of BaiduDoc and swf2pdf
* BaiduDoc https://github.com/Hacksign/BaiduDoc/
* swf2pdf https://github.com/zyp001a/swf2pdf

