// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:test_job_thing/model/candidates.dart';
import 'package:test_job_thing/model/blogs.dart';
import 'package:test_job_thing/model/address.dart';
import 'package:test_job_thing/model/emails.dart';
import 'package:test_job_thing/model/experiences.dart';
import 'package:test_job_thing/model/merge.dart';

class ApiCallCandidate {
  static Future<List<Candidate>> getCandidate(String query) async {
    await dotenv.load(fileName: '.env');
    final URL = dotenv.env['API_URL'];

    final response = await http.get(Uri.parse('$URL/candidates'));
    if (response.statusCode == 200) {
      final List candidates = json.decode(response.body)['results'];
      return candidates
          .map((json) => Candidate.fromJson(json))
          .where((element) {
        final nameLower = element.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return nameLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}

class ApiCallBlog {
  static Future<List<Blog>> getBlogs(String query) async {
    await dotenv.load(fileName: '.env');
    final URL = dotenv.env['API_URL'];

    final responseBlogs = await http.get(Uri.parse('$URL/blogs'));
    if (responseBlogs.statusCode == 200) {
      final List blogs = json.decode(responseBlogs.body)['results'];
      return blogs.map((json) => Blog.fromJson(json)).where((element) {
        final titleLower = element.title.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}

class ApiCallAddress {
  Future<List<Address>> getAddress() async {
    await dotenv.load(fileName: '.env');
    final URL = dotenv.env['API_URL'];

    final responseAddress = await http.get(Uri.parse('$URL/address'));
    if (responseAddress.statusCode == 200) {
      final List address = json.decode(responseAddress.body)['results'];
      return address.map((json) => Address.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}

class ApiCallEmails {
  Future<List<Email>> getEmails() async {
    await dotenv.load(fileName: '.env');
    final URL = dotenv.env['API_URL'];

    final responseEmails = await http.get(Uri.parse('$URL/emails'));
    if (responseEmails.statusCode == 200) {
      final List emails = json.decode(responseEmails.body)['results'];
      return emails.map((json) => Email.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}

class ApiCallExperience {
  Future<List<Experience>> getExperience() async {
    await dotenv.load(fileName: '.env');
    final URL = dotenv.env['API_URL'];

    final responseExperience = await http.get(Uri.parse('$URL/experiences'));
    if (responseExperience.statusCode == 200) {
      final List experience = json.decode(responseExperience.body)['results'];
      return experience.map((json) => Experience.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}

class ApiMerge {
  Future<List<Merge>> getMergeData(String query) async {
    await dotenv.load(fileName: '.env');
    final URL = dotenv.env['API_URL'];

    final responseCandidate = await http.get(Uri.parse('$URL/candidates'));
    final responseEmails = await http.get(Uri.parse('$URL/emails'));
    final responseAddress = await http.get(Uri.parse('$URL/address'));
    final responseExperience = await http.get(Uri.parse('$URL/experiences'));
    if (responseEmails.statusCode == 200 && responseAddress.statusCode == 200) {
      List candidates = jsonDecode(responseCandidate.body)['results'];
      List emails = jsonDecode(responseEmails.body)['results'];
      List address = jsonDecode(responseAddress.body)['results'];
      List experiences = jsonDecode(responseExperience.body)['results'];

      List<Merge> merger = [];
      for (int i = 0; i < candidates.length; i++) {
        merger.add(Merge(
            id: candidates[i]['id'],
            name: candidates[i]['name'],
            gender: candidates[i]['gender'],
            photo: candidates[i]['photo'],
            birthday: candidates[i]['birthday'],
            expired: candidates[i]['expired'],
            email: emails[i + 1]['email'],
            phone: emails[i + 1]['phone'],
            address: address[i + 1]['address'],
            city: address[i + 1]['city'],
            state: address[i + 1]['state'],
            zipCode: address[i + 1]['zip_code'],
            status: experiences[i + 1]['status'],
            jobTitle: experiences[i + 1]['job_title'],
            companyName: experiences[i + 1]['company_name'],
            industry: experiences[i + 1]['industry']));
      }
      return merger.where((element) {
        final titleLower = element.name.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception('Json data download error');
    }
  }
}
