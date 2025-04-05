use v6.c;

use Method::Also;

use GEXIV2::Raw::Types;
use GEXIV2::Raw::Preview::Image;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GExiv2PreviewPropertiesAncestry is export of Mu
  where GExiv2PreviewProperties | GObject;

class GEXIV2::Preview::Properties {
  also does GLib::Roles::Object;

  has GExiv2PreviewProperties $!epp is implementor;

  submethod BUILD ( :$exiv-preview-props ) {
    self.setGExiv2PreviewProperties($exiv-preview-props)
      if $exiv-preview-props
  }

  method setGExiv2PreviewProperties (GExiv2PreviewPropertiesAncestry $_) {
    my $to-parent;

    $!epp = do {
      when GExiv2PreviewProperties {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GExiv2PreviewProperties, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEXIV2::Raw::Definitions::GExiv2PreviewProperties
    is also<GExiv2PreviewProperties>
  { $!epp }

  multi method new (
    $exiv-preview-props where * ~~ GExiv2PreviewPropertiesAncestry ,

    :$ref = True
  ) {
    return unless $exiv-preview-props;

    my $o = self.bless( :$exiv-preview-props );
    $o.ref if $ref;
    $o;
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
    gexiv2_preview_properties_get_extension($!epp);
  }

  method get_height
    is also<
      get-height
      height
      h
    >
  {
    gexiv2_preview_properties_get_height($!epp);
  }

  method get_mime_type
    is also<
      get-mime-type
      mime_type
      mime-type
    >
  {
    gexiv2_preview_properties_get_mime_type($!epp);
  }

  method get_size
    is also<
      get-size
      size
    >
  {
    gexiv2_preview_properties_get_size($!epp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gexiv2_preview_properties_get_type,
      $n,
      $t
    );
  }

  method get_width
    is also<
      get-width
      width
      w
    >
  {
    gexiv2_preview_properties_get_width($!epp);
  }

}
