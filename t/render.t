use Test::More tests => 7;

use HTML::FormHandler::Field::Text;


{
   package Test::Form;
   use Moose;
   extends 'HTML::FormHandler';
   with 'HTML::FormHandler::Render::Simple';

   sub field_list
   {
      return {
         fields => {
            TestField => {
               type => 'Text',
               label => 'TEST',
               id    => 'f99',
               value => 'something'
            },
            fruit      => 'Select',
            vegetables => 'Multiple',
            active     => 'Checkbox',
            comments   => 'TextArea',
            hidden     => 'Hidden',
            selected   => 'Boolean',
         }
      },
   }

   sub options_fruit {
       return (
           1   => 'apples',
           2   => 'oranges',
           3   => 'kiwi',
       );
   }

   sub options_vegetables {
       return (
           1   => 'lettuce',
           2   => 'broccoli',
           3   => 'carrots',
           4   => 'peas',
       );
   }
}

my $form = Test::Form->new;

ok( $form, 'create form');

my $output1 = $form->render_field( $form->field('TestField') );
ok( $output1, 'output from text field');

my $output2 = $form->render_field( $form->field('fruit') );
ok( $output2, 'output from select field');

my $output3 = $form->render_field( $form->field('vegetables') );
ok( $output3, 'output from select multiple field');

my $output4 = $form->render_field( $form->field('active') );
ok( $output4, 'output from checkbox field');

my $output5 = $form->render_field( $form->field('comments') );
ok( $output5, 'output from textarea' );

my $output6 = $form->render_field( $form->field('hidden') );
ok( $output6, 'output from textarea' );

my $output7 = $form->render_field( $form->field('selected') );
ok( $output7, 'output from boolean' );

$output = $form->render;
ok( $output, 'get rendered output from form');
