use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GEXIV2::Raw::Definitions;

unit package GEXIV2::Raw::Preview::Properties;

### /home/cbwood/Projects/gexiv2/gexiv2/gexiv2-preview-properties.h

sub gexiv2_preview_properties_get_extension (GExiv2PreviewProperties $self)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_properties_get_height (GExiv2PreviewProperties $self)
  returns guint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_properties_get_mime_type (GExiv2PreviewProperties $self)
  returns Str
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_properties_get_size (GExiv2PreviewProperties $self)
  returns guint32
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_properties_get_type
  returns GType
  is      native(gexiv2)
  is      export
{ * }

sub gexiv2_preview_properties_get_width (GExiv2PreviewProperties $self)
  returns guint32
  is      native(gexiv2)
  is      export
{ * }
