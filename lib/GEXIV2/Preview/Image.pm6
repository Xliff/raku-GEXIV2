use v6.c;

use Method::Also;

use GEXIV2::Raw::Types;
use GEXIV2::Raw::Preview::Image;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GExiv2PreviewImageAncestry is export of Mu
  where GExiv2PreviewImage | GObject;

class GEXIV2::Preview::Image {
  also does GLib::Roles::Object;

  has GExiv2PreviewImage $!epi is implementor;

  submethod BUILD ( :$exiv-preview-image ) {
    self.setGExiv2PreviewImage($exiv-preview-image) if $exiv-preview-image;
  }

  method setGExiv2PreviewImage (GExiv2PreviewImageAncestry $_) {
    my $to-parent;

    $!epi = do {
      when GExiv2PreviewImage {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GExiv2PreviewImage, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEXIV2::Raw::Definitions::GExiv2PreviewImage
    is also<GExiv2PreviewImage>
  { $!epi }

  multi method new (
    $exiv-preview-image where * ~~ GExiv2PreviewImageAncestry,

    :$ref = True
  ) {
    return unless $exiv-preview-image;

    my $o = self.bless( :$exiv-preview-image );
    $o.ref if $ref;
    $o;
  }

  method free {
    gexiv2_preview_image_free($!epi);
  }

  proto method get_data (|)
    is also<
      get-data
      data
    >
  { * }

  method get_data {
    samewith($);
  }
  method get_data ($size is rw, :$raw = False, :$buf = True) {
    my gulong $s = 0;

    my $ca = gexiv2_preview_image_get_data($!epi, $s);
    $size = $s;
    return $ca if $raw;
    $ca = SizedCArray.new($ca, $s);
    return $ca unless $buf;
    Buf[uint8].new($ca);
  }

  method get_dimensions
    is also<
      dimensions
      dim
      wh
    >
  {
    ($.get_width, $.get_height)
  }

  method get_extension
    is also<
      get-extension
      extension
      ext
    >
  {
    gexiv2_preview_image_get_extension($!epi);
  }

  method get_height
    is also<
      get-height
      height
      h
    >
  {
    gexiv2_preview_image_get_height($!epi);
  }

  method get_mime_type
    is also<
      get-mime-type
      mime-type
      mime_type
    >
  {
    gexiv2_preview_image_get_mime_type($!epi);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gexiv2_preview_image_get_type, $n, $t );
  }

  method get_width
    is also<
      get-width
      width
      w
    >
  {
    gexiv2_preview_image_get_width($!epi);
  }

  method try_write_file (
    Str()                   $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-write-file>
  {
    clear_error;
    my $r = gexiv2_preview_image_try_write_file($!epi, $path, $error);
    set_error($error);
    $r
  }

  method write_file (Str() $path)
    is DEPRECATED('try_write_file')
    is also<write-file>
  {
    gexiv2_preview_image_write_file($!epi, $path);
  }

}
