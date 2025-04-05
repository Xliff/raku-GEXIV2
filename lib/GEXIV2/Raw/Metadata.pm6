use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Structs;
use GEXIV2::Raw::Definitions;

unit package GEXIV2::Raw::Metadata;

### /home/cbwood/Projects/gexiv2/gexiv2/gexiv2-metadata.h

sub gexiv2_metadata_as_bytes (
  GExiv2Metadata          $self,
  GBytes                  $bytes,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_clear (GExiv2Metadata $self)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_clear_comment (GExiv2Metadata $self)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_clear_exif (GExiv2Metadata $self)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_clear_iptc (GExiv2Metadata $self)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_clear_tag (
  GExiv2Metadata $self,
  Str            $tag
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_clear_tag')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_clear_xmp (GExiv2Metadata $self)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_delete_gps_info (GExiv2Metadata $self)
  is      DEPRECATED('gexiv2_metadata_try_delete_gps_info')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_erase_exif_thumbnail (GExiv2Metadata $self)
  is      DEPRECATED('gexiv2_metadata_try_erase_exif_thumbnail')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_free (GExiv2Metadata $self)
  is      DEPRECATED('g_object_unref')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_from_app1_segment (
  GExiv2Metadata          $self,
  guint8                  $data is rw,
  glong                   $n_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_from_stream (
  GExiv2Metadata          $self,
  GInputStream            $stream,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_generate_xmp_packet (
  GExiv2Metadata       $self,
  GExiv2XmpFormatFlags $xmp_format_flags,
  guint32              $padding
)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_generate_xmp_packet')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_comment (GExiv2Metadata $self)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_comment')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_exif_data (
  GExiv2Metadata          $self,
  GExiv2ByteOrder         $byte_order,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_exif_tag_rational (
  GExiv2Metadata $self,
  Str            $tag,
  gint           $nom is rw,
  gint           $den is rw
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_get_exif_tag_rational')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_exif_tags (GExiv2Metadata $self)
  returns CArray[Str]
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_exif_thumbnail (
  GExiv2Metadata         $self,
  CArray[CArray[guint8]] $buffer,
  gint                   $size    is rw
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_exposure_time (
  GExiv2Metadata $self,
  gint           $nom is rw,
  gint           $den is rw
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_get_exposure_time')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_fnumber (GExiv2Metadata $self)
  returns gdouble
  is      DEPRECATED('gexiv2_metadata_try_get_fnumber')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_focal_length (GExiv2Metadata $self)
  returns gdouble
  is      DEPRECATED('gexiv2_metadata_try_get_focal_length')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_gps_altitude (
  GExiv2Metadata $self,
  gdouble        $altitude is rw
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_get_gps_altitude')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_gps_info (
  GExiv2Metadata $self,
  gdouble        $longitude is rw,
  gdouble        $latitude is rw,
  gdouble        $altitude is rw
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_get_gps_info')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_gps_latitude (
  GExiv2Metadata $self,
  gdouble        $latitude is rw
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_get_gps_latitude')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_gps_longitude (
  GExiv2Metadata $self,
  gdouble        $longitude is rw
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_get_gps_longitude')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_iptc_tags (GExiv2Metadata $self)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_iso_speed (GExiv2Metadata $self)
  returns gint
  is      DEPRECATED('gexiv2_metadata_try_get_iso_speed')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_metadata_pixel_height (GExiv2Metadata $self)
  returns gint
  is      DEPRECATED('gexiv2_metadata_try_get_metadata_pixel_height')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_metadata_pixel_width (GExiv2Metadata $self)
  returns gint
  is      DEPRECATED('gexiv2_metadata_try_get_metadata_pixel_width')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_mime_type (GExiv2Metadata $self)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_orientation (GExiv2Metadata $self)
  returns GExiv2Orientation
  is      DEPRECATED('gexiv2_metadata_try_get_orientation')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_pixel_height (GExiv2Metadata $self)
  returns gint
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_pixel_width (GExiv2Metadata $self)
  returns gint
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_preview_image (
  GExiv2Metadata          $self,
  GExiv2PreviewProperties $props
)
  returns GExiv2PreviewImage
  is      DEPRECATED('gexiv2_metadata_try_get_preview_image')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_preview_properties (GExiv2Metadata $self)
  returns CArray[CArray[GExiv2PreviewProperties]]
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_supports_exif (GExiv2Metadata $self)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_supports_iptc (GExiv2Metadata $self)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_supports_xmp (GExiv2Metadata $self)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_description (Str $tag)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_tag_description')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_interpreted_string (
  GExiv2Metadata $self,
  Str            $tag
)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_tag_interpreted_string')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_label (Str $tag)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_tag_label')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_long (
  GExiv2Metadata $self,
  Str            $tag
)
  returns glong
  is      DEPRECATED('gexiv2_metadata_try_get_tag_long')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_multiple (
  GExiv2Metadata $self,
  Str            $tag
)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_tag_multiple')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_raw (
  GExiv2Metadata $self,
  Str            $tag
)
  returns GBytes
  is      DEPRECATED('gexiv2_metadata_try_get_tag_raw')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_string (
  GExiv2Metadata $self,
  Str            $tag
)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_tag_string')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_tag_type (Str $tag)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_tag_type')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_type
  returns GType
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_xmp_namespace_for_tag (Str $tag)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_xmp_namespace_for_tag')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_xmp_packet (GExiv2Metadata $self)
  returns Str
  is      DEPRECATED('gexiv2_metadata_try_get_xmp_packet')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_get_xmp_tags (GExiv2Metadata $self)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_has_exif (GExiv2Metadata $self)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_has_iptc (GExiv2Metadata $self)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_has_tag (
  GExiv2Metadata $self,
  Str            $tag
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_has_tag')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_has_xmp (GExiv2Metadata $self)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_is_exif_tag (Str $tag)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_is_iptc_tag (Str $tag)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_is_xmp_tag (Str $tag)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_new
  returns GExiv2Metadata
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_open_buf (
  GExiv2Metadata          $self,
  guint8                  $data is rw,
  glong                   $n_data,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_open_path (
  GExiv2Metadata          $self,
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_register_xmp_namespace (
  Str $name,
  Str $prefix
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_register_xmp_namespace')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_save_external (
  GExiv2Metadata          $self,
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_save_file (
  GExiv2Metadata          $self,
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_comment (
  GExiv2Metadata $self,
  Str            $comment
)
  is      DEPRECATED('gexiv2_metadata_try_set_comment')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_exif_tag_rational (
  GExiv2Metadata $self,
  Str            $tag,
  gint           $nom,
  gint           $den
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_set_exif_tag_rational')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_exif_thumbnail_from_buffer (
  GExiv2Metadata $self,
  guint8         $buffer is rw,
  gint           $size
)
  is      DEPRECATED('gexiv2_metadata_try_set_exif_thumbnail_from_buffer')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_exif_thumbnail_from_file (
  GExiv2Metadata          $self,
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_gps_info (
  GExiv2Metadata $self,
  gdouble        $longitude,
  gdouble        $latitude,
  gdouble        $altitude
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_set_gps_info')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_metadata_pixel_height (
  GExiv2Metadata $self,
  gint           $height
)
  is      DEPRECATED('gexiv2_metadata_try_set_metadata_pixel_height')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_metadata_pixel_width (
  GExiv2Metadata $self,
  gint           $width
)
  is      DEPRECATED('gexiv2_metadata_try_set_metadata_pixel_width')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_orientation (
  GExiv2Metadata    $self,
  GExiv2Orientation $orientation
)
  is      DEPRECATED('gexiv2_metadata_try_set_orientation')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_tag_long (
  GExiv2Metadata $self,
  Str            $tag,
  glong          $value
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_set_tag_long')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_tag_multiple (
  GExiv2Metadata $self,
  Str            $tag,
  CArray[Str]    $values
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_set_tag_multiple')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_tag_string (
  GExiv2Metadata $self,
  Str            $tag,
  Str            $value
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_set_tag_string')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_set_xmp_tag_struct (
  GExiv2Metadata      $self,
  Str                 $tag,
  GExiv2StructureType $type
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_set_xmp_tag_struct')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_clear_tag (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_delete_gps_info (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_erase_exif_thumbnail (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_generate_xmp_packet (
  GExiv2Metadata          $self,
  GExiv2XmpFormatFlags    $xmp_format_flags,
  guint32                 $padding,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_comment (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_exif_tag_rational (
  GExiv2Metadata          $self,
  Str                     $tag,
  gint                    $nom is rw,
  gint                    $den is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_exposure_time (
  GExiv2Metadata          $self,
  gint                    $nom is rw,
  gint                    $den is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_fnumber (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns gdouble
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_focal_length (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns gdouble
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_gps_altitude (
  GExiv2Metadata          $self,
  gdouble                 $altitude is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_gps_info (
  GExiv2Metadata          $self,
  gdouble                 $longitude is rw,
  gdouble                 $latitude is rw,
  gdouble                 $altitude is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_gps_latitude (
  GExiv2Metadata          $self,
  gdouble                 $latitude is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_gps_longitude (
  GExiv2Metadata          $self,
  gdouble                 $longitude is rw,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_iso_speed (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns gint
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_metadata_pixel_height (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns gint
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_metadata_pixel_width (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns gint
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_orientation (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns GExiv2Orientation
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_preview_image (
  GExiv2Metadata          $self,
  GExiv2PreviewProperties $props,
  CArray[Pointer[GError]] $error
)
  returns GExiv2PreviewImage
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_description (
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_interpreted_string (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_label (
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_long (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns glong
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_multiple (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_raw (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns GBytes
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_string (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_tag_type (
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_xmp_namespace_for_tag (
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_get_xmp_packet (
  GExiv2Metadata          $self,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_has_tag (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_register_xmp_namespace (
  Str                     $name,
  Str                     $prefix,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_comment (
  GExiv2Metadata          $self,
  Str                     $comment,
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_exif_tag_rational (
  GExiv2Metadata          $self,
  Str                     $tag,
  gint                    $nom,
  gint                    $den,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_exif_thumbnail_from_buffer (
  GExiv2Metadata          $self,
  guint8                  $buffer is rw,
  gint                    $size,
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_gps_info (
  GExiv2Metadata          $self,
  gdouble                 $longitude,
  gdouble                 $latitude,
  gdouble                 $altitude,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_metadata_pixel_height (
  GExiv2Metadata          $self,
  gint                    $height,
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_metadata_pixel_width (
  GExiv2Metadata          $self,
  gint                    $width,
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_orientation (
  GExiv2Metadata          $self,
  GExiv2Orientation       $orientation,
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_tag_long (
  GExiv2Metadata          $self,
  Str                     $tag,
  glong                   $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_tag_multiple (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Str]             $values,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_tag_string (
  GExiv2Metadata          $self,
  Str                     $tag,
  Str                     $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_set_xmp_tag_struct (
  GExiv2Metadata          $self,
  Str                     $tag,
  GExiv2StructureType     $type,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_tag_supports_multiple_values (
  GExiv2Metadata          $self,
  Str                     $tag,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_unregister_all_xmp_namespaces (
  CArray[Pointer[GError]] $error
)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_unregister_xmp_namespace (
  Str                     $name,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_try_update_gps_info (
  GExiv2Metadata          $self,
  gdouble                 $longitude,
  gdouble                 $latitude,
  gdouble                 $altitude,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_unregister_all_xmp_namespaces
  is      DEPRECATED('gexiv2_metadata_try_unregister_all_xmp_namespaces')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_unregister_xmp_namespace (Str $name)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_unregister_xmp_namespace')
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_metadata_update_gps_info (
  GExiv2Metadata $self,
  gdouble        $longitude,
  gdouble        $latitude,
  gdouble        $altitude
)
  returns uint32
  is      DEPRECATED('gexiv2_metadata_try_update_gps_info')
  is      native(gexiv2)
  is      export
{ * }
