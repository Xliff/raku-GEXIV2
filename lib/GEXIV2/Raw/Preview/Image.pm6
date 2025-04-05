use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GEXIV2::Raw::Definitions;

unit package GEXIV2::Raw::Preview::Image;

### /home/cbwood/Projects/gexiv2/gexiv2/gexiv2-preview-image.h

sub gexiv2_preview_image_free (GExiv2PreviewImage $self)
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_image_get_data (
  GExiv2PreviewImage $self,
  guint32            $size is rw
)
  returns CArray[uint8]
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_image_get_extension (GExiv2PreviewImage $self)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_image_get_height (GExiv2PreviewImage $self)
  returns guint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_image_get_mime_type (GExiv2PreviewImage $self)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_image_get_type
  returns GType
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_image_get_width (GExiv2PreviewImage $self)
  returns guint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_image_try_write_file (
  GExiv2PreviewImage      $self,
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns glong
  is      native(gexiv2)
  is      export
{ * }

# cw: DEPRECATED FOR THE ABOVE ROUTINE
sub gexiv2_preview_image_write_file (
  GExiv2PreviewImage $self,
  Str                $path
)
  returns glong
  is      native(gexiv2)
  is      export
{ * }
