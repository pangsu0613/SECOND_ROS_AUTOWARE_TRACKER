# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from autoware_config_msgs/ConfigDecisionMaker.msg. Do not edit."""
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import std_msgs.msg

class ConfigDecisionMaker(genpy.Message):
  _md5sum = "fe838f93691743bfb359111aef81dd4d"
  _type = "autoware_config_msgs/ConfigDecisionMaker"
  _has_header = True #flag to mark the presence of a Header object
  _full_text = """Header header
bool enable_force_state_change
bool enable_display_marker
float64 convergence_threshold
uint32 convergence_count
uint32 target_waypoint
uint32 stopline_target_waypoint
float64 stopline_target_ratio
float64 shift_width

float64 crawl_velocity
float64 detection_area_rate

string baselink_tf

float64 detection_area_x1
float64 detection_area_x2
float64 detection_area_y1
float64 detection_area_y2
================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
# 0: no frame
# 1: global frame
string frame_id
"""
  __slots__ = ['header','enable_force_state_change','enable_display_marker','convergence_threshold','convergence_count','target_waypoint','stopline_target_waypoint','stopline_target_ratio','shift_width','crawl_velocity','detection_area_rate','baselink_tf','detection_area_x1','detection_area_x2','detection_area_y1','detection_area_y2']
  _slot_types = ['std_msgs/Header','bool','bool','float64','uint32','uint32','uint32','float64','float64','float64','float64','string','float64','float64','float64','float64']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       header,enable_force_state_change,enable_display_marker,convergence_threshold,convergence_count,target_waypoint,stopline_target_waypoint,stopline_target_ratio,shift_width,crawl_velocity,detection_area_rate,baselink_tf,detection_area_x1,detection_area_x2,detection_area_y1,detection_area_y2

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(ConfigDecisionMaker, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.header is None:
        self.header = std_msgs.msg.Header()
      if self.enable_force_state_change is None:
        self.enable_force_state_change = False
      if self.enable_display_marker is None:
        self.enable_display_marker = False
      if self.convergence_threshold is None:
        self.convergence_threshold = 0.
      if self.convergence_count is None:
        self.convergence_count = 0
      if self.target_waypoint is None:
        self.target_waypoint = 0
      if self.stopline_target_waypoint is None:
        self.stopline_target_waypoint = 0
      if self.stopline_target_ratio is None:
        self.stopline_target_ratio = 0.
      if self.shift_width is None:
        self.shift_width = 0.
      if self.crawl_velocity is None:
        self.crawl_velocity = 0.
      if self.detection_area_rate is None:
        self.detection_area_rate = 0.
      if self.baselink_tf is None:
        self.baselink_tf = ''
      if self.detection_area_x1 is None:
        self.detection_area_x1 = 0.
      if self.detection_area_x2 is None:
        self.detection_area_x2 = 0.
      if self.detection_area_y1 is None:
        self.detection_area_y1 = 0.
      if self.detection_area_y2 is None:
        self.detection_area_y2 = 0.
    else:
      self.header = std_msgs.msg.Header()
      self.enable_force_state_change = False
      self.enable_display_marker = False
      self.convergence_threshold = 0.
      self.convergence_count = 0
      self.target_waypoint = 0
      self.stopline_target_waypoint = 0
      self.stopline_target_ratio = 0.
      self.shift_width = 0.
      self.crawl_velocity = 0.
      self.detection_area_rate = 0.
      self.baselink_tf = ''
      self.detection_area_x1 = 0.
      self.detection_area_x2 = 0.
      self.detection_area_y1 = 0.
      self.detection_area_y2 = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs))
      _x = self.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      _x = self
      buff.write(_get_struct_2Bd3I4d().pack(_x.enable_force_state_change, _x.enable_display_marker, _x.convergence_threshold, _x.convergence_count, _x.target_waypoint, _x.stopline_target_waypoint, _x.stopline_target_ratio, _x.shift_width, _x.crawl_velocity, _x.detection_area_rate))
      _x = self.baselink_tf
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      _x = self
      buff.write(_get_struct_4d().pack(_x.detection_area_x1, _x.detection_area_x2, _x.detection_area_y1, _x.detection_area_y2))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    try:
      if self.header is None:
        self.header = std_msgs.msg.Header()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.header.frame_id = str[start:end].decode('utf-8')
      else:
        self.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 54
      (_x.enable_force_state_change, _x.enable_display_marker, _x.convergence_threshold, _x.convergence_count, _x.target_waypoint, _x.stopline_target_waypoint, _x.stopline_target_ratio, _x.shift_width, _x.crawl_velocity, _x.detection_area_rate,) = _get_struct_2Bd3I4d().unpack(str[start:end])
      self.enable_force_state_change = bool(self.enable_force_state_change)
      self.enable_display_marker = bool(self.enable_display_marker)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.baselink_tf = str[start:end].decode('utf-8')
      else:
        self.baselink_tf = str[start:end]
      _x = self
      start = end
      end += 32
      (_x.detection_area_x1, _x.detection_area_x2, _x.detection_area_y1, _x.detection_area_y2,) = _get_struct_4d().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs))
      _x = self.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      _x = self
      buff.write(_get_struct_2Bd3I4d().pack(_x.enable_force_state_change, _x.enable_display_marker, _x.convergence_threshold, _x.convergence_count, _x.target_waypoint, _x.stopline_target_waypoint, _x.stopline_target_ratio, _x.shift_width, _x.crawl_velocity, _x.detection_area_rate))
      _x = self.baselink_tf
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.pack('<I%ss'%length, length, _x))
      _x = self
      buff.write(_get_struct_4d().pack(_x.detection_area_x1, _x.detection_area_x2, _x.detection_area_y1, _x.detection_area_y2))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    try:
      if self.header is None:
        self.header = std_msgs.msg.Header()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.header.frame_id = str[start:end].decode('utf-8')
      else:
        self.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 54
      (_x.enable_force_state_change, _x.enable_display_marker, _x.convergence_threshold, _x.convergence_count, _x.target_waypoint, _x.stopline_target_waypoint, _x.stopline_target_ratio, _x.shift_width, _x.crawl_velocity, _x.detection_area_rate,) = _get_struct_2Bd3I4d().unpack(str[start:end])
      self.enable_force_state_change = bool(self.enable_force_state_change)
      self.enable_display_marker = bool(self.enable_display_marker)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.baselink_tf = str[start:end].decode('utf-8')
      else:
        self.baselink_tf = str[start:end]
      _x = self
      start = end
      end += 32
      (_x.detection_area_x1, _x.detection_area_x2, _x.detection_area_y1, _x.detection_area_y2,) = _get_struct_4d().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e) #most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_3I = None
def _get_struct_3I():
    global _struct_3I
    if _struct_3I is None:
        _struct_3I = struct.Struct("<3I")
    return _struct_3I
_struct_4d = None
def _get_struct_4d():
    global _struct_4d
    if _struct_4d is None:
        _struct_4d = struct.Struct("<4d")
    return _struct_4d
_struct_2Bd3I4d = None
def _get_struct_2Bd3I4d():
    global _struct_2Bd3I4d
    if _struct_2Bd3I4d is None:
        _struct_2Bd3I4d = struct.Struct("<2Bd3I4d")
    return _struct_2Bd3I4d