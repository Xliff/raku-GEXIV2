use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Exceptions;

use GLib::Roles::Pointers;

unit package GEXIV2::Raw::Definitions;

our $GEXIV2_INIT_ON_STARTUP is export = True;

constant gexiv2 is export = 'gexiv2',v2;

class GExiv2Metadata          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GExiv2PreviewImage      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GExiv2PreviewProperties is repr<CPointer> does GLib::Roles::Pointers is export { }

constant GExiv2XmpFormatFlags is export := guint64;
our enum GExiv2XmpFormatFlagsEnum is export (
  GEXIV2_OMIT_PACKET_WRAPPER   => 0x0010,
  GEXIV2_READ_ONLY_PACKET      => 0x0020,
  GEXIV2_USE_COMPACT_FORMAT    => 0x0040,
  GEXIV2_INCLUDE_THUMBNAIL_PAD => 0x0100,
  GEXIV2_EXACT_PACKET_LENGTH   => 0x0200,
  GEXIV2_WRITE_ALIAS_COMMENTS  => 0x0400,
  GEXIV2_OMIT_ALL_FORMATTING   => 0x0800
);

constant GExiv2Orientation is export := guint32;
our enum GExiv2OrientationEnum is export (
  GEXIV2_ORIENTATION_MIN          => 0,
  GEXIV2_ORIENTATION_UNSPECIFIED  => 0,
  GEXIV2_ORIENTATION_NORMAL       => 1,
  GEXIV2_ORIENTATION_HFLIP        => 2,
  GEXIV2_ORIENTATION_ROT_180      => 3,
  GEXIV2_ORIENTATION_VFLIP        => 4,
  GEXIV2_ORIENTATION_ROT_90_HFLIP => 5,
  GEXIV2_ORIENTATION_ROT_90       => 6,
  GEXIV2_ORIENTATION_ROT_90_VFLIP => 7,
  GEXIV2_ORIENTATION_ROT_270      => 8,
  GEXIV2_ORIENTATION_MAX          => 8
);

constant GExiv2StructureType is export := guint32;
our enum GExiv2StructureTypeEnum is export (
  GEXIV2_STRUCTURE_XA_NONE => 0,
  GEXIV2_STRUCTURE_XA_ALT  => 20,
  GEXIV2_STRUCTURE_XA_BAG  => 21,
  GEXIV2_STRUCTURE_XA_SEQ  => 22,
  GEXIV2_STRUCTURE_XA_LANG => 23
);

constant GExiv2ByteOrder is export := guint32;
enum GExiv2ByteOrderEnum is export (
  GEXIV2_BYTE_ORDER_LITTLE => 0,
  GEXIV2_BYTE_ORDER_BIG    => 1
);

our class X::GEXIV2::Metadata::UnknownTagType
  is X::GLib::Exception
  is export
{
  has $!tag is built;

  method new ($tag) {
    self.bless(
      :$tag,

      message => "Invalid metadata tag name: { $tag }";
    );
  }
}
