use v6.c;

use Method::Also;

use NativeCall;

use GEXIV2::Raw::Types;
use GEXIV2::Raw::Metadata;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GExiv2MetadataAncestry is export of Mu
  where GExiv2Metadata | GObject;

class GEXIV2::Metadata {
  also does GLib::Roles::Object;

  has GExiv2Metadata $!em is implementor;

  submethod BUILD ( :$exiv-metadata ) {
    self.setGExiv2Metadata($exiv-metadata) if $exiv-metadata
  }

  method setGExiv2Metadata (GExiv2MetadataAncestry $_) {
    my $to-parent;

    $!em = do {
      when GExiv2Metadata {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GExiv2Metadata, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GEXIV2::Raw::Definitions::GExiv2Metadata
    is also<GExiv2Metadata>
  { $!em }

  multi method new (
    $exiv-metadata where * ~~ GExiv2MetadataAncestry,

    :$ref = True
  ) {
    return unless $exiv-metadata;

    my $o = self.bless( :$exiv-metadata );
    $o.ref if $ref;
    $o;
  }

  multi method new {
    my $exiv-metadata = gexiv2_metadata_new();

    $exiv-metadata ?? self.bless( :$exiv-metadata ) !! Nil
  }

  proto method as_bytes (|)
    is also<as-bytes>
  { * }

  multi method as_bytes (
    :$error = gerror,
    :$bytes = GBytes,
    :$raw   = False,
    :$buf   = True
  ) {
    samewith($bytes, $error, :$raw, :$buf);
  }
  multi method as_bytes (
    GBytes()                 $bytes,
    CArray[Pointer[GError]]  $error  = gerror,
                            :$raw    = False,
                            :$buf    = True
  ) {
    my $b = propReturnObject(
      gexiv2_metadata_as_bytes($!em, $bytes, $error),
      $raw,
      |GLib::Bytes.getTypePair
    );
    return $b unless $buf;
    $b.Buf
  }

  method clear {
    gexiv2_metadata_clear($!em);
  }

  method clear_comment is also<clear-comment> {
    gexiv2_metadata_clear_comment($!em);
  }

  method clear_exif is also<clear-exif> {
    gexiv2_metadata_clear_exif($!em);
  }

  method clear_iptc is also<clear-iptc> {
    gexiv2_metadata_clear_iptc($!em);
  }

  method clear_tag (Str() $tag)
    is DEPRECATED('try_clear_tag')

    is also<clear-tag>
  {
    gexiv2_metadata_clear_tag($!em, $tag);
  }

  method clear_xmp is also<clear-xmp> {
    gexiv2_metadata_clear_xmp($!em);
  }

  method delete_gps_info
    is DEPRECATED('try_delete_gps_info')
    is also<delete-gps-info>
  {
    gexiv2_metadata_delete_gps_info($!em);
  }

  method erase_exif_thumbnail
    is DEPRECATED('try_erase_exif_thumbnail')
    is also<erase-exif-thumbnail>
  {
    gexiv2_metadata_erase_exif_thumbnail($!em);
  }

  method free
    is DEPRECATED('g_object_unref')
  {
    gexiv2_metadata_free($!em);
  }

  proto method from_app1_segment (|)
    is also<from-app1-segment>
  { * }

  multi method from_app1_segment (
    Blob()                  $data,
    CArray[Pointer[GError]] $error = gerror
  ) {
    samewith($data, $data.bytes, $error);
  }
  multi method from_app1_segment (
    CArray[uint8]           $data,
    Int()                   $n_data,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    my glong $n = $n_data;

    clear_error;
    my $r = so gexiv2_metadata_from_app1_segment($!em, $data, $n_data, $error);
    set_error($error);
    $r
  }

  method from_stream (
    GInputStream()          $stream,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<from-stream>
  {
    clear_error;
    my $r = so gexiv2_metadata_from_stream($!em, $stream, $error);
    set_error($error);
    $r;
  }

  method generate_xmp_packet (Int() $xmp_format_flags, Int() $padding)
    is DEPRECATED('try_generate_xmp_packet')
    is also<generate-xmp-packet>
  {
    my GExiv2XmpFormatFlags $x = $xmp_format_flags;
    my guint32              $p = $padding;

    gexiv2_metadata_generate_xmp_packet($!em, $x, $p);
  }

  method get_comment
    is DEPRECATED('try_get_comment')
    is also<get-comment>
  {
    gexiv2_metadata_get_comment($!em);
  }

  method get_exif_data (
    Int()                    $byte_order,
    CArray[Pointer[GError]]  $error       = gerror,
                            :$raw         = False,
                            :$buf         = False
  )
    is also<get-exif-data>
  {
    my GExiv2ByteOrder $b = $byte_order;

    clear_error;
    my $r = gexiv2_metadata_get_exif_data($!em, $b, $error);
    set_error($error);
    $r = propReturnObject($r, $raw, |GLib::Bytes.getTypePair);
    return $r unless $buf;
    $r.Buf;
  }

  proto method get_exif_tag_rational (|)
    is also<get-exif-tag-rational>
  { * }

  multi method get_exif_tag_rational ($tag) {
    samewith($tag, $, $);
  }
  multi method get_exif_tag_rational (
    Str() $tag,
          $nom  is rw,
          $den  is rw
  )
    is DEPRECATED('try_get_exif_tag_rational')
  {
    my gint ($n, $d) = 0 xx 2;

    gexiv2_metadata_get_exif_tag_rational($!em, $tag, $n, $d);
    ($nom, $den) = ($n, $d);
    $n / $d;
  }

  method get_exif_tags ( :$raw = False ) is also<get-exif-tags> {
    my $ca = gexiv2_metadata_get_exif_tags($!em);
    return $ca if $raw;
    CArrayToArray($ca);
  }

  proto method get_exif_thumbnail (|)
    is also<get-exif-thumbnail>
  { * }

  multi method get_exif_thumbnail ( :$raw = False, :$buf = True ) {
    samewith( newCArray(CArray[uint8]), $, :$raw, :$buf );
  }
  multi method get_exif_thumbnail (
    CArray[CArray[uint8]]  $buffer,
                           $size    is rw,
                          :$raw            = False,
                          :$buf            = True
  ) {
    my gint $s = 0;

    my $r = so gexiv2_metadata_get_exif_thumbnail($!em, $buffer, $s);
    $size = $s;

    return Nil unless $r;

    my $b = ppr($buffer);
    return $b if $raw;

    $b = SizedCArray($b, $s);
    return $b unless $buf;

    Buf[uint8].new($b);
  }

  proto method get_exposure_time (|)
    is also<get-exposure-time>
  { * }

  multi method get_exposure_time {
    samewith($, $);
  }
  multi method get_exposure_time ($nom is rw, $den is rw)
    is DEPRECATED('try_get_exposure_time')
  {
    my gint ($n, $d) = 0 xx 2;

    gexiv2_metadata_get_exposure_time($!em, $nom, $den);
    ($nom, $den) = ($n, $d);
    $n / $d;
  }

  method get_fnumber
    is DEPRECATED('try_get_fnumber')
    is also<get-fnumber>
  {
    gexiv2_metadata_get_fnumber($!em);
  }

  method get_focal_length
    is DEPRECATED('try_get_focal_length')
    is also<get-focal-length>
  {
    gexiv2_metadata_get_focal_length($!em);
  }

  proto method get_gps_altitude (|)
    is also<get-gps-altitude>
  { * }

  multi method get_gps_altitude {
    samewith($);
  }
  multi method get_gps_altitude ($altitude is rw)
    is DEPRECATED('try_get_gps_altitude')
  {
    my gdouble $a = 0e0;

    gexiv2_metadata_get_gps_altitude($!em, $a);
    $altitude = $a;
  }

  proto method get_gps_info (|)
    is also<get-gps-info>
  { * }

  multi method get_gps_info {
    samewith($, $, $);
  }
  multi method get_gps_info (
    $longitude is rw,
    $latitude  is rw,
    $altitude  is rw
  )
    is DEPRECATED('try_get_gps_info')
  {
    my gdouble ($lon, $lat, $a) = 0e0 xx 3;

    gexiv2_metadata_get_gps_info($!em, $lon, $lat, $a);
    ($longitude, $latitude, $altitude) = ($lon, $lat, $a);
  }

  proto method get_gps_latitude (|)
    is also<get-gps-latitude>
  { * }

  multi method get_gps_latitude {
    samewith($);
  }
  multi method get_gps_latitude ($latitude is rw)
    is DEPRECATED('try_get_gps_latitude')
  {
    my gdouble $l = 0e0;

    gexiv2_metadata_get_gps_latitude($!em, $l);
    $latitude = $l
  }

  proto method get_gps_longitude (|)
    is also<get-gps-longitude>
  { * }

  multi method get_gps_longitude {
    samewith($);
  }
  multi method get_gps_longitude ($longitude is rw)
    is DEPRECATED('try_get_gps_longitude')
  {
    my gdouble $l = 0e0;

    gexiv2_metadata_get_gps_longitude($!em, $l);
    $longitude = $l;
  }

  method get_iptc_tags ( :$raw = False ) is also<get-iptc-tags> {
    my $ca = gexiv2_metadata_get_iptc_tags($!em);
    return $ca if $raw;
    CArrayToArray($ca);
  }

  method get_iso_speed
    is DEPRECATED('try_get_iso_speed')
    is also<get-iso-speed>
  {
    gexiv2_metadata_get_iso_speed($!em);
  }

  method get_metadata_pixel_height
    is DEPRECATED('try_get_metadata_pixel_height')
    is also<get-metadata-pixel-height>
  {
    gexiv2_metadata_get_metadata_pixel_height($!em);
  }

  method get_metadata_pixel_width
    is DEPRECATED('try_get_metadata_pixel_width')
    is also<get-metadata-pixel-width>
  {
    gexiv2_metadata_get_metadata_pixel_width($!em);
  }

  method get_mime_type is also<get-mime-type> {
    gexiv2_metadata_get_mime_type($!em);
  }

  method get_orientation ( :$enum = True )
    is DEPRECATED('try_get_orientation')
    is also<get-orientation>
  {
    my $o = gexiv2_metadata_get_orientation($!em);
    return $o unless $enum;
    GExiv2OrientationEnum($o);
  }

  method get_pixel_height is also<get-pixel-height> {
    gexiv2_metadata_get_pixel_height($!em);
  }

  method get_pixel_width is also<get-pixel-width> {
    gexiv2_metadata_get_pixel_width($!em);
  }

  method get_preview_image (GExiv2PreviewProperties() $props, :$raw = False)
    is DEPRECATED('try_get_preview_image')

    is also<get-preview-image>
  {
    propReturnObject(
      gexiv2_metadata_get_preview_image($!em, $props),
      $raw,
      |GEXIV2::Preview::Image.getTypePair
    );
  }

  method get_preview_properties ( :$raw = False )
    is also<get-preview-properties>
  {
    propReturnObject(
      gexiv2_metadata_get_preview_properties($!em),
      $raw,
      |GEXIV2::Preview::Properties.getTypePair
    );
  }

  method get_supports_exif is also<get-supports-exif> {
    so gexiv2_metadata_get_supports_exif($!em);
  }

  method get_supports_iptc is also<get-supports-iptc> {
    so gexiv2_metadata_get_supports_iptc($!em);
  }

  method get_supports_xmp is also<get-supports-xmp> {
    so gexiv2_metadata_get_supports_xmp($!em);
  }

  method get_tag_description (Str() $tag)
    is DEPRECATED('try_get_tag_description')
    is also<get-tag-description>
  {
    gexiv2_metadata_get_tag_description($tag);
  }

  method get_tag_interpreted_string (Str() $tag)
    is DEPRECATED('try_get_tag_interpreted_string')
    is also<get-tag-interpreted-string>
  {
    gexiv2_metadata_get_tag_interpreted_string($!em, $tag);
  }

  method get_tag_label (Str() $tag)
    is DEPRECATED('try_get_tag_label')
    is also<get-tag-label>
  {
    gexiv2_metadata_get_tag_label($tag);
  }

  method get_tag_long (Str() $tag)
    is DEPRECATED('try_get_tag_long')
    is also<get-tag-long>
  {
    gexiv2_metadata_get_tag_long($!em, $tag);
  }

  method get_tag_multiple (Str() $tag, :$raw = False)
    is DEPRECATED('try_get_tag_multiple')
    is also<get-tag-multiple>
  {
    my $ca = gexiv2_metadata_get_tag_multiple($!em, $tag);
    return $ca if $raw;
    CArrayToArray($ca);
  }

  method get_tag_raw (Str() $tag, :$raw = False, :$buf = True)
    is DEPRECATED('try_get_tag_raw')
    is also<get-tag-raw>
  {
    my $b = propReturnObject(
      gexiv2_metadata_get_tag_raw($!em, $tag),
      $raw,
      |GLib::Bytes.getTypePair
    );
    return $b unless $buf;
    $b.Buf;
  }

  method get_tag_string (Str() $tag)
    is DEPRECATED('try_get_tag_string')
    is also<get-tag-string>
  {
    gexiv2_metadata_get_tag_string($!em, $tag);
  }

  method get_tag_type (Str() $tag)
    is DEPRECATED('try_get_tag_type')s
    is also<get-tag-type>
  {
    gexiv2_metadata_get_tag_type($tag);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gexiv2_metadata_get_type, $n, $t );
  }

  method get_xmp_namespace_for_tag (Str() $tag)
    is DEPRECATED('try_get_xmp_namespace_for_tag')\
    is also<get-xmp-namespace-for-tag>
  {
    gexiv2_metadata_get_xmp_namespace_for_tag($tag);
  }

  method get_xmp_packet
    is DEPRECATED('try_get_xmp_packet')
    is also<get-xmp-packet>
  {
    gexiv2_metadata_get_xmp_packet($!em);
  }

  method get_xmp_tags ( :$raw = False ) is also<get-xmp-tags> {
    my $ca = gexiv2_metadata_get_xmp_tags($!em);
    return $ca if $raw;
    CArrayToArray($ca);
  }

  method has_exif is also<has-exif> {
    so gexiv2_metadata_has_exif($!em);
  }

  method has_iptc is also<has-iptc> {
    so gexiv2_metadata_has_iptc($!em);
  }

  method has_tag (Str() $tag)
    is DEPRECATED('try_has_tag')
    is also<has-tag>
  {
    so gexiv2_metadata_has_tag($!em, $tag);
  }

  method has_xmp is also<has-xmp> {
    so gexiv2_metadata_has_xmp($!em);
  }

  method is_exif_tag (Str() $tag) is also<is-exif-tag> {
    so gexiv2_metadata_is_exif_tag($tag);
  }

  method is_iptc_tag (Str() $tag) is also<is-iptc-tag> {
    so gexiv2_metadata_is_iptc_tag($tag);
  }

  method is_xmp_tag (Str() $tag) is also<is-xmp-tag> {
    so gexiv2_metadata_is_xmp_tag($tag);
  }

  proto method open_buf (|)
    is also<open-buf>
  { * }

  multi method open_buf (Blob() $data, $error = gerror) {
    samewith(
      CArray[uint8].new($data),
      $data.bytes,
      $error
    );
  }
  multi method open_buf (
    CArray[guint8]          $data,
    Int()                   $n_data,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    my glong $n = $n_data;

    clear_error;
    my $r = so gexiv2_metadata_open_buf($!em, $data, $n, $error);
    set_error($error);
    $r;
  }

  method open_path (
    Str()                   $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<open-path>
  {
    clear_error;
    my $r = so gexiv2_metadata_open_path($!em, $path, $error);
    set_error($error);
    $r;
  }

  method register_xmp_namespace (Str() $name, Str() $prefix)
    is DEPRECATED('try_register_xmp_namespace')
    is also<register-xmp-namespace>
  {
    so gexiv2_metadata_register_xmp_namespace($name, $prefix);
  }

  method save_external (
    Str()                   $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<save-external>
  {
    clear_error;
    my $r = so gexiv2_metadata_save_external($!em, $path, $error);
    set_error($error);
    $r;
  }

  method save_file (
    Str()                   $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<save-file>
  {
    clear_error;
    my $r = so gexiv2_metadata_save_file($!em, $path, $error);
    set_error($error);
    $r;
  }

  method set_comment (Str() $comment)
    is DEPRECATED('try_set_comment')
    is also<set-comment>
  {
    gexiv2_metadata_set_comment($!em, $comment);
  }

  method set_exif_tag_rational (Str() $tag, Int() $nom, Int() $den)
    is DEPRECATED('try_set_exif_tag_rational')s
    is also<set-exif-tag-rational>
  {
    my gint ($n, $d) = ($nom, $den);

    gexiv2_metadata_set_exif_tag_rational($!em, $tag, $n, $d);
  }

  proto method set_exif_thumbnail_from_buffer (|)
    is also<set-exif-thumbnail-from-buffer>
  { * }

  multi method set_exif_thumbnail_from_buffer (Blob() $buffer) {
    samewith( CArray[uint8].new($buffer), $buffer.bytes );
  }
  multi method set_exif_thumbnail_from_buffer (
    CArray[uint8]  $buffer is rw,
    Int()          $size
  )
    is DEPRECATED('try_set_exif_thumbnail_from_buffer')
  {
    my gint $s = $size;

    gexiv2_metadata_set_exif_thumbnail_from_buffer($!em, $buffer, $s);
  }

  method set_exif_thumbnail_from_file (
    Str()                   $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<set-exif-thumbnail-from-file>
  {
    clear_error;
    my $r = so gexiv2_metadata_set_exif_thumbnail_from_file(
      $!em,
      $path,
      $error
    );
    set_error($error);
    $r;
  }

  method set_gps_info (
    Num() $longitude,
    Num() $latitude,
    Num() $altitude
  )
    is DEPRECATED('try_set_gps_info')
    is also<set-gps-info>
  {
    my gdouble ($lat, $lon, $a) = ($latitude, $longitude, $altitude);

    gexiv2_metadata_set_gps_info($!em, $lon, $lat, $a);
  }

  method set_metadata_pixel_height (Int() $height)
    is DEPRECATED('try_set_metadata_pixel_height')
    is also<set-metadata-pixel-height>
  {
    my gint $h = $height;

    so gexiv2_metadata_set_metadata_pixel_height($!em, $h);
  }

  method set_metadata_pixel_width (Int() $width)
    is DEPRECATED('try_set_metadata_pixel_width')
    is also<set-metadata-pixel-width>
  {
    my gint $w = $width;

    gexiv2_metadata_set_metadata_pixel_width($!em, $w);
  }

  method set_orientation (Int() $orientation)
    is DEPRECATED('try_set_orientation')
    is also<set-orientation>
  {
    my GExiv2Orientation $o = $orientation;

    gexiv2_metadata_set_orientation($!em, $o);
  }

  method set_tag_long (Str() $tag, Int() $value)
    is DEPRECATED('try_set_tag_long')
    is also<set-tag-long>
  {
    my glong $v = $value;

    gexiv2_metadata_set_tag_long($!em, $tag, $v);
  }

  proto method set_tag_multiple (|)
    is also<set-tag-multiple>
  { * }

  multi method set_tag_multiple ($tag, @values) {
    samewith( $tag, ArrayToCArray(Str, @values, :null) )
  }
  multi method set_tag_multiple (Str() $tag, CArray[Str] $values)
    is DEPRECATED('try_set_tag_multiple')
  {
    gexiv2_metadata_set_tag_multiple($!em, $tag, $values);
  }

  method set_tag_string (Str() $tag, Str() $value)
    is DEPRECATED('try_set_tag_string')

    is also<set-tag-string>
  {
    gexiv2_metadata_set_tag_string($!em, $tag, $value);
  }

  method set_xmp_tag_struct (Str() $tag, Int() $type)
    is DEPRECATED('try_set_xmp_tag_struct')
    is also<set-xmp-tag-struct>
  {
    my GExiv2StructureType $t = $type;

    gexiv2_metadata_set_xmp_tag_struct($!em, $tag, $t);
  }

  method try_clear_tag (
    Str                     $tag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-clear-tag>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_clear_tag($!em, $tag, $error);
    set_error($error);
    $r;
  }

  method try_delete_gps_info (CArray[Pointer[GError]] $error = gerror)
    is also<try-delete-gps-info>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_delete_gps_info($!em, $error);
    set_error($error);
  }

  method try_erase_exif_thumbnail (CArray[Pointer[GError]] $error = gerror )
    is also<try-erase-exif-thumbnail>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_erase_exif_thumbnail($!em, $error);
    set_error($error);
    $r
  }

  method try_generate_xmp_packet (
    Int()                   $xmp_format_flags,
    Int()                   $padding,
    CArray[Pointer[GError]] $error             = gerror
  )
    is also<try-generate-xmp-packet>
  {
    my GExiv2XmpFormatFlags $x = $xmp_format_flags;
    my guint32              $p = $padding;

    clear_error;
    my $r = gexiv2_metadata_try_generate_xmp_packet(
      $!em,
      $xmp_format_flags,
      $p,
      $error
    );
    set_error($error);
    $r;
  }

  method getTag (Str() $tag) {
    do given $.try_get_tag_type($tag) {
      when 'Ascii'   |
           'Comment'     { $.try_get_tag_string($tag) }

      when 'Byte'      |
           'Short'     |
           'Long'        { $.try_get_tag_long($tag) }

      when 'Rational'  |
           'SRational'   { $.try_get_exif_tag_rational($tag) }

      when 'Undefined'   { $.try_get_tag_raw($tag) }

      default {
        X::GEXIV2::Metadata::UnknownTagType.new($_).throw
      }
    }
  }

  method try_get_comment (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-comment>
  {
    clear_error;
    my $r = gexiv2_metadata_try_get_comment($!em, $error);
    set_error($error);
    $r;
  }

  proto method try_get_exif_tag_rational (|)
    is also<try-get-exif-tag-rational>
  { * }

  multi method try_get_exif_tag_rational (Str() $tag, $error = gerror) {
    samewith($tag, $, $, $error);
  }
  multi method try_get_exif_tag_rational (
    Str                     $tag,
                            $nom    is rw,
                            $den    is rw,
    CArray[Pointer[GError]] $error
  ) {
    my gint ($n, $d) = 0 xx 2;

    clear_error;
    my $r = gexiv2_metadata_try_get_exif_tag_rational(
      $!em,
      $tag,
      $n,
      $d,
      $error
    );
    set_error($error);
    ($nom, $den) = ($n, $d);

    return Nil unless $r;
    $n / $d;
  }

  proto method try_get_exposure_time (|)
    is also<try-get-exposure-time>
  { * }

  multi method try_get_exposure_time ($error = gerror) {
    samewith($, $, $error);
  }
  multi method try_get_exposure_time (
                            $nom    is rw,
                            $den    is rw,
    CArray[Pointer[GError]] $error         = gerror
  ) {
    my gint ($n, $d) = 0 xx 2;

    clear_error;
    my $r = so gexiv2_metadata_try_get_exposure_time($!em, $n, $d, $error);
    set_error($error);
    ($nom, $den) = ($n, $d);

    return Nil unless $r;
    $n / $d;
  }

  method try_get_fnumber (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-fnumber>
  {
    clear_error;
    my $r = gexiv2_metadata_try_get_fnumber($!em, $error);
    set_error($error);
    $r;
  }

  method try_get_focal_length (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-focal-length>
  {
    clear_error;
    my $r = gexiv2_metadata_try_get_focal_length($!em, $error);
    set_error($error);
    $r;
  }

  proto method try_get_gps_altitude (|)
    is also<try-get-gps-altitude>
  { * }

  multi method try_get_gps_altitude ($error = gerror) {
    samewith($, $error);
  }
  multi method try_get_gps_altitude (
                            $altitude is rw,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    my gdouble $a = 0e0;

    clear_error;
    my $r = so gexiv2_metadata_try_get_gps_altitude($!em, $a, $error);
    set_error($error);
    return Nil unless $r;
    $altitude = $a;
  }

  proto method try_get_gps_info (|)
    is also<try-get-gps-info>
  { *}

  multi method try_get_gps_info ($error = gerror) {
    samewith($, $, $, $error);
  }
  multi method try_get_gps_info (
                            $longitude is rw,
                            $latitude  is rw,
                            $altitude  is rw,
    CArray[Pointer[GError]] $error            = gerror
  ) {
    my gdouble ($lon, $lat, $a) = 0e0 xx 3;;

    clear_error;
    my $r = so gexiv2_metadata_try_get_gps_info($!em, $lon, $lat, $a, $error);
    set_error($error);

    return Nil unless $r;
    ($longitude, $latitude, $altitude) = ($lon, $lat, $a);
  }

  proto method try_get_gps_latitude (|)
    is also<try-get-gps-latitude>
  { * }

  multi method try_get_gps_latitude ($error = gerror) {
    samewith($, $error);
  }
  multi method try_get_gps_latitude (
                            $latitude is rw,
    CArray[Pointer[GError]] $error           = gerror
  ) {
    my gdouble $l = 0e0;

    clear_error;
    my $r = so gexiv2_metadata_try_get_gps_latitude($!em, $l, $error);
    set_error($error);
    return Nil unless $r;
    $latitude = $l;
  }

  proto method try_get_gps_longitude (|)
    is also<try-get-gps-longitude>
  { * }

  multi method try_get_gps_longitude ($error = gerror) {
    samewith($, $error);
  }
  multi method try_get_gps_longitude (
                            $longitude is rw,
    CArray[Pointer[GError]] $error
  ) {
    my gdouble $l = 0e0;

    clear_error;
    my $r = gexiv2_metadata_try_get_gps_longitude($!em, $l, $error);
    set_error($error);
    return Nil unless $r;
    $longitude = $l;
  }

  method try_get_iso_speed (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-iso-speed>
  {
    clear_error;
    my $r = gexiv2_metadata_try_get_iso_speed($!em, $error);
    set_error($error);
    $r;
  }

  method try_get_metadata_pixel_height (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-metadata-pixel-height>
  {
    clear_error;
    my $r = gexiv2_metadata_try_get_metadata_pixel_height($!em, $error);
    set_error($error);
    $r
  }

  method try_get_metadata_pixel_width (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-metadata-pixel-width>
  {
    clear_error;
    my $r = gexiv2_metadata_try_get_metadata_pixel_width($!em, $error);
    set_error($error);
    $r;
  }

  method try_get_orientation (
    CArray[Pointer[GError]]  $error = gerror,
                            :$enum  = True
  )
    is also<try-get-orientation>
  {
    clear_error;
    my $o = gexiv2_metadata_try_get_orientation($!em, $error);
    set_error($error);
    return $o unless $enum;
    GExiv2OrientationEnum($o);
  }

  method try_get_preview_image (
    GExiv2PreviewProperties()  $props,
    CArray[Pointer[GError]]    $error  = gerror,
                              :$raw    = False
  )
    is also<try-get-preview-image>
  {
    clear_error;
    my $i = gexiv2_metadata_try_get_preview_image($!em, $props, $error);
    set_error($error);
    propReturnObject($i, $raw, |GEVIV2::Preview::Image.getTypePair);
  }

  method try_get_tag_description (
    Str()                   $tag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-tag-description>
  {
    clear_error;
    my $d = gexiv2_metadata_try_get_tag_description($tag, $error);
    set_error($error);
    $d;
  }

  method try_get_tag_interpreted_string (
    Str()                   $tag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-tag-interpreted-string>
  {
    clear_error;
    my $s = gexiv2_metadata_try_get_tag_interpreted_string(
      $!em,
      $tag,
      $error
    );
    set_error($error);
    $s;
  }

  method try_get_tag_label (
    Str()                   $tag,
    CArray[Pointer[GError]] $error
  )
    is also<try-get-tag-label>
  {
    clear_error;
    my $l = gexiv2_metadata_try_get_tag_label($tag, $error);
    set_error($error);
    $l
  }

  method try_get_tag_long (
    Str()                   $tag,
    CArray[Pointer[GError]] $error
  )
    is also<try-get-tag-long>
  {
    clear_error;
    my $l = gexiv2_metadata_try_get_tag_long($!em, $tag, $error);
    set_error($error);
    $l;
  }

  method try_get_tag_multiple (
    Str()                    $tag,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw  = False
  )
    is also<try-get-tag-multiple>
  {
    clear_error;
    my $ca = gexiv2_metadata_try_get_tag_multiple(
      $!em,
      $tag,
      $error
    );
    set_error($error);
    return $ca if $raw;
    CArrayToArray($ca);
  }

  method try_get_tag_raw (
    Str()                    $tag,
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False,
                            :$buf   = True
  )
    is also<try-get-tag-raw>
  {
    clear_error;
    my $b = gexiv2_metadata_try_get_tag_raw($!em, $tag, $error);
    set_error($error);
    $b = propReturnObject($b, $raw, |GLib::Bytes.getTypePair);
    return $b unless $buf;
    $b.Buf;
  }

  method try_get_tag_string (
    Str()                   $tag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-tag-string>
  {
    clear_error;
    my $s = gexiv2_metadata_try_get_tag_string($!em, $tag, $error);
    set_error($error);
    $s;
  }

  method try_get_tag_type (
    Str()                   $tag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-get-tag-type>
  {
    clear_error;
    my $t = gexiv2_metadata_try_get_tag_type($tag, $error);
    set_error($error);
    $t;
  }

  method try_get_xmp_namespace_for_tag (
    Str()                   $tag,
    CArray[Pointer[GError]] $error
  )
    is also<try-get-xmp-namespace-for-tag>
  {
    clear_error;
    my $n = gexiv2_metadata_try_get_xmp_namespace_for_tag($tag, $error);
    set_error($error);
    $n;
  }

  method try_get_xmp_packet (CArray[Pointer[GError]] $error = gerror)
    is also<try-get-xmp-packet>
  {
    clear_error;
    my $p = gexiv2_metadata_try_get_xmp_packet($!em, $error);
    set_error($error);
    $p;
  }

  method try_has_tag (
    Str()                   $tag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-has-tag>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_has_tag($!em, $tag, $error);
    set_error($error);
    $r;s
  }

  method try_register_xmp_namespace (
    Str()                   $name,
    Str()                   $prefix,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<try-register-xmp-namespace>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_register_xmp_namespace(
      $name,
      $prefix,
      $error
    );
    set_error($error);
    $r;
  }

  method try_set_comment (
    Str()                   $comment,
    CArray[Pointer[GError]] $error     = gerror
  )
    is also<try-set-comment>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_set_comment($!em, $comment, $error);
    set_error($error);
    $r;
  }

  method try_set_exif_tag_rational (
    Str()                   $tag,
    Int()                   $nom,
    Int()                   $den,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-set-exif-tag-rational>
  {
    my gint ($n, $d) = ($nom, $den);

    clear_error;
    my $r = so gexiv2_metadata_try_set_exif_tag_rational(
      $!em,
      $tag,
      $n,
      $d,
      $error
    );
    set_error($error);
    $r;
  }

  proto method try_set_exif_thumbnail_from_buffer (|)
    is also<try-set-exif-thumbnail-from-buffer>
  { * }

  multi method try_set_exif_thumbnail_from_buffer (@buffer, $error = gerror) {
    samewith( CArray[uint8].new(@buffer), @buffer.elems, $error );
  }
  method try_set_exif_thumbnail_from_buffer (Blob $buffer, $error = gerror) {
    samewith( CArray[uint8].new($buffer), $buffer.bytes, $error );
  }
  method try_set_exif_thumbnail_from_buffer (
    CArray[uint8]           $buffer,
    Int()                   $size,
    CArray[Pointer[GError]] $error = gerror
  ) {
    my gint $s = $size;

    clear_error;
    my $r = so gexiv2_metadata_try_set_exif_thumbnail_from_buffer(
      $!em,
      $buffer,
      $s,
      $error
    );
    set_error($error);
    $r;
  }

  method try_set_gps_info (
    Num()                   $longitude,
    Num()                   $latitude,
    Num()                   $altitude,
    CArray[Pointer[GError]] $error       = gerror
  )
    is also<try-set-gps-info>
  {
    my gdouble ($lon, $lat, $a) = ($longitude, $latitude, $altitude);

    clear_error;
    my $r = so gexiv2_metadata_try_set_gps_info($!em, $lon, $lat, $a, $error);
    set_error($error);
    $r;
  }

  method try_set_metadata_pixel_height (
    Int()                   $height,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<try-set-metadata-pixel-height>
  {
    my gint $h = $height;

    clear_error;
    my $r = so gexiv2_metadata_try_set_metadata_pixel_height(
      $!em,
      $h,
      $error
    );
    set_error($error);
    $r;
  }

  method try_set_metadata_pixel_width (
    Int()                   $width,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<try-set-metadata-pixel-width>
  {
    my gint $w = $width;

    clear_error;
    my $r = so gexiv2_metadata_try_set_metadata_pixel_width($!em, $w, $error);
    set_error($error);
  }

  method try_set_orientation (
    Int()                   $orientation,
    CArray[Pointer[GError]] $error        = gerror
  )
    is also<try-set-orientation>
  {
    my GExiv2Orientation $o = $orientation;

    clear_error;
    my $r = so gexiv2_metadata_try_set_orientation($!em, $o, $error);
    set_error($error);
    $r;
  }

  method try_set_tag_long (
    Str()                   $tag,
    Int()                   $value,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<try-set-tag-long>
  {
    my glong $v = $value;

    clear_error;
    my $r = so gexiv2_metadata_try_set_tag_long($!em, $tag, $v, $error);
    set_error($error);
    $r;
  }

  proto method try_set_tag_multiple (|)
    is also<try-set-tag-multiple>
  { * }

  multi method try_set_tag_multiple (Str() $tag, @values, $error = gerror) {
    samewith($tag, ArrayToCArray(Str, @values), $error);
  }
  multi method try_set_tag_multiple (
    Str                     $tag,
    CArray[Str]             $values,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $r = so gexiv2_metadata_try_set_tag_multiple(
      $!em,
      $tag,
      $values,
      $error
    );
    set_error($error);
    $rf;
  }

  method try_set_tag_string (
    Str()                   1$tag,
    Str()                   $value,
    CArray[Pointer[GError]] $error   = gerror;
  )
    is also<try-set-tag-string>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_set_tag_string($!em, $tag, $value, $error);
    set_error($error);
    $r;
  }

  method try_set_xmp_tag_struct (
    Str()                   $tag,
    Int()                   $type,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-set-xmp-tag-struct>
  {
    my GExiv2StructureType $t = $type;

    clear_error;
    my $r = so gexiv2_metadata_try_set_xmp_tag_struct($!em, $tag, $t, $error);
    set_error($error);
    $r;
  }

  method try_tag_supports_multiple_values (
    Str()                   $tag,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-tag-supports-multiple-values>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_tag_supports_multiple_values(
      $!em,
      $tag,
      $error
    );
    set_error($error);
    $r;
  }

  method try_unregister_all_xmp_namespaces (
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-unregister-all-xmp-namespaces>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_unregister_all_xmp_namespaces($error);
    set_error($error);
    $r;
  }

  method try_unregister_xmp_namespace (
    Str()                   $name,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<try-unregister-xmp-namespace>
  {
    clear_error;
    my $r = so gexiv2_metadata_try_unregister_xmp_namespace($name, $error);
    set_error($error);
    $r;
  }

  method try_update_gps_info (
    Num()                   $longitude,
    Num()                   $latitude,
    Num()                   $altitude,
    CArray[Pointer[GError]] $error      = gerror
  )
    is also<try-update-gps-info>
  {
    my gdouble ($lon, $lat, $a) = ($longitude, $latitude, $altitude);

    clear_error;
    my $r = so gexiv2_metadata_try_update_gps_info(
      $!em,
      $lon,
      $lat,
      $a,
      $error
    );
    set_error($error);l
    $r;
  }

  method unregister_all_xmp_namespaces
    is DEPRECATED('try_unregister_all_xmp_namespaces')

    is also<unregister-all-xmp-namespaces>
  {
    so gexiv2_metadata_unregister_all_xmp_namespaces();
  }

  method unregister_xmp_namespace (Str() $ns)
    is DEPRECATED('try_unregister_xmp_namespace')

    is also<unregister-xmp-namespace>
  {
    so gexiv2_metadata_unregister_xmp_namespace($ns);
  }

  method update_gps_info (
    Num() $longitude,
    Num() $latitude,
    Num() $altitude
  )
    is DEPRECATED('try_update_gps_info')

    is also<update-gps-info>
  {
    my gdouble ($lon, $lat, $a) = ($longitude, $latitude, $altitude);

    gexiv2_metadata_update_gps_info($!em, $lon, $lat, $a);
  }

}
