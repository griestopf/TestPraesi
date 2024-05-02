#!/usr/bin/env python3
from pathlib import Path
import os
import sys
import argparse
import bpy

class ArgumentParserForBlender(argparse.ArgumentParser):
    """
    This class is identical to its superclass, except for the parse_args
    method (see docstring). It resolves the ambiguity generated when calling
    Blender from the CLI with a python script, and both Blender and the script
    have arguments. E.g., the following call will make Blender crash because
    it will try to process the script's -a and -b flags:
    >>> blender --python my_script.py -a 1 -b 2

    To bypass this issue this class uses the fact that Blender will ignore all
    arguments given after a double-dash ('--'). The approach is that all
    arguments before '--' go to Blender, arguments after go to the script.
    The following calls work fine:
    >>> blender --python my_script.py -- -a 1 -b 2
    >>> blender --python my_script.py --
    """

    def _get_argv_after_doubledash(self):
        """
        Given the sys.argv as a list of strings, this method returns the
        sublist right after the '--' element (if present, otherwise returns
        ~an empty list~ the original argv list).
        """
        try:
            idx = sys.argv.index("--")
            return sys.argv[idx+1:] # the list after '--'
        except ValueError as e: # '--' not in the list:
            return sys.argv[1:]

    # overrides superclass
    def parse_args(self):
        """
        This method is expected to behave identically as in the superclass,
        except that the sys.argv list will be pre-processed using
        _get_argv_after_doubledash before. See the docstring of the class for
        usage examples and details.
        """
        return super().parse_args(args=self._get_argv_after_doubledash())


if __name__ == "__main__":
    # parser = argparse.ArgumentParser()
    parser = ArgumentParserForBlender()
   
    parser.add_argument("-i", "--input", help="blender file to convert", default="", type=Path)
    parser.add_argument("-o", "--output", help="blender file to convert", default="", type=Path)
    # parser.add_argument(
    #     "-r", "--root", help="path to serve as root (relative to `platform/web/`)", default="../../bin", type=Path
    # )
    # browser_parser = parser.add_mutually_exclusive_group(required=False)
    # browser_parser.add_argument(
    #     "-n", "--no-browser", help="don't open default web browser automatically", dest="browser", action="store_false"
    # )
    # parser.set_defaults(browser=True)
    args = parser.parse_args()

    # Change to the directory where the script is located,
    # so that the script can be run from any location.
    # os.chdir(Path(__file__).resolve().parent)
    bpy.ops.wm.open_mainfile(filepath=str(args.input))
    bpy.ops.export_scene.gltf(filepath=str(args.output))
