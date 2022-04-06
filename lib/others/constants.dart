import 'package:logger/logger.dart';

import 'my_file_output.dart';

Logger logger = Logger(printer: PrettyPrinter(), output: MyFileOutput());
