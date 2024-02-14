import 'package:flutter/material.dart';
import 'package:labz/repositories/index.dart';
import 'package:provider/provider.dart';

import '../widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductRepository productRepository = ProductRepository();
  int limit = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState(){
    super.initState();
    getFutureData();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255,137,139,140)),
      ),      
        title: Row(
          children: [
            Image.asset(
              'assets/images/academy.jpg',
              height: 60, width: 60,
              ),   
              const SizedBox(width: 6),
             const Text('academy', 
             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255,46,46,46)),),
          ],
        )),
      body: NotificationListener<ScrollNotification>(
              // ignore: missing_return
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  getProductDetails();
                }
                return false;
              },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255,244,249,250),
          margin: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Consumer<ProductRepository>(
              builder: (context, productRepository, Widget? _) {
                // get items from provider
                final products = productRepository.products;
                if(products != null){
                  if(products.runtimeType == String){
                    return const Center(
                      child: Text('No products available'),
                    );
                  } else{
                    if(limit<products.length){
                      limit = products.length;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                            // show the number of items currently in list
                          child: Text('Showing ${products.length} Courses', 
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255,46,46,46)),),
                        ),   
                        // show items list    
                        ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
                            decoration: BoxDecoration(color: Colors.white,
                            borderRadius: BorderRadius.circular(16),),
                            // card for all items
                            child: CourseCard(course: products[index]),
                          );
                        }),
                      ],
                    );
                  }
                } else {
                  return const CircularProgressIndicator();
                }
            })                                                         
          ),
        ),
      )
      );
  }
  
  void getFutureData() {
    getProductDetails();
  }
  // method to get courses
  Future<void> getProductDetails() async{
    await Provider.of<ProductRepository>(context, listen: false).getProduct(limit: limit+5);
  }
}
